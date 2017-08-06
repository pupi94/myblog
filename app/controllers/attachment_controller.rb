class AttachmentController < ApplicationController
=begin
  def download
    begin
      file_path = params['file_path']
      file_name = file_path.split('/').last
      file_type = file_name.split('.').last
      result = FileLoadByAliyun.download(file_path)
      if result["return_code"] == 0
        send_data result["return_info"], :type => file_type.to_sym.downcase, :filename => URI.decode(file_name), :disposition => "inline"
      else
        logger.error "download file from aliyun failed: params[#{params}], result[#{result}]"
      end
    rescue Exception => e
      logger.error e
    end
  end

  # service_name:    附件所属对象所在服务的名称简写
  # attachment_type: 附件类型
  # attachment_id:   附件所属对象id, 如果所属对象还未创建，可以使当前用户id
  # object_name:       附件存储表名
  # object_id:       附件存储表，标识ID
  def update
    @result = {'return_code' => 0, 'return_info' => 'success'}
    begin
      raise "unknow attachment_type: #{params['attachment_type']}" unless ALL_ATTACHMENT_TYPES.include?(params['attachment_type'])
      service_name = params['service_name']
      attachment_type = params['attachment_type']
      attachment_id = params['attachment_id']
      attachment_name = params['attachment_name'].present? ? params['attachment_name'] : DateTime.now.strftime("%Y%m%d%H%M%S") # 临时文件夹
      object_name = params['object_name']
      object_id = params['object_id']

      if params["upload_attachment"].present? && object_id.blank?
        case attachment_type
          when 'driver'
            result = Driver.update_supplement('id' => attachment_id)
            object_id = result['driver_supplement_id'] if result["result"]["return_code"] == ErrorCode::SUCCESS
          when 'fleet', 'vehicle'
            create_params = {}
            create_params[attachment_type] = {}
            create_params[attachment_type]['id'] = attachment_id
            result = attachment_type.camelize.constantize.update_supplement(create_params)
            object_id = result["#{attachment_type}_supplement_id"] if result["return_code"] == ErrorCode::SUCCESS
          when 'transport_receipt'
            new_params = {'sales_order_id' => attachment_id, 'servicer_uid' => current_user.number, 'servicer_name' => current_user.name}
            result = TransportReceiptLsms.confirm(new_params)
            object_id = result['id'] if result["return_code"] == ErrorCode::SUCCESS
        end
      end

      update_params = {'attachment_type' => attachment_type,
                       'attachment_id' => attachment_id,
                       'delete_files' => params['delete_files'],
                       'attachment_name' => attachment_name}

      if params["upload_attachment"].present?
        raise "#{object_name} is not exist, need 'object_id' param." if object_id.blank?
        upload_result = FileLoadByAliyun.upload(params["upload_attachment"], service_name, object_name, object_id, attachment_name)
        if upload_result.is_a?(Hash) && upload_result["return_code"] == 0
          update_params['add_files'] = upload_result['return_info'].split('-||-')
        end
      end

      case attachment_type
        when 'order', 'charge'
          update_params['id'] = attachment_id
          update_params.delete('attachment_id')
          @result = Order.update_attachment(update_params)
        when 'work_order_exception'
          @result = WorkOrder.update_exception_attachment(update_params)
        when 'work_order_task'
          @result = WorkOrder.update_task_attachment(update_params)
        when 'driver_identification_supplement'
          @result = Driver.update_identification_attachment(update_params)
        when 'payment_register'
          # 从session中读取register_attachment 【有且仅当登记付款申请时】
          update_params['attachment'] = payment_register_attachment_session[current_user.id]
          update_params['id'] = attachment_id
          @result = PaymentRegister.update_attachment(update_params)
          payment_register_attachment_session[current_user.id] = @result['attachment'] if (attachment_id.blank? && OptilinkUtils::Util.is_success?(@result)) # 当attachment_id = nil 即 登记付款，则需要记录session
        when 'bank_account'
          # 从session中读取bank_account_attachment
          update_params['attachment'] = bank_account_attachment_session[current_user.id]
          update_params['id'] = attachment_id
          @result = BankAccount.update_attachment(update_params)

          #如果未创建银行账户，需要save to session
          bank_account_attachment_session[current_user.id] = @result['attachment'] if (attachment_id.blank? && OptilinkUtils::Util.is_success?(@result))
        when 'transport_receipt'
          @result = TransportReceiptLsms.update_attachment(update_params)
        else
          @result = attachment_type.camelize.constantize.update_attachment(update_params)
      end
    rescue Exception => e
      logger.error e
      @result = {'return_code' => 1, 'return_info' => e.message}
    end

    render json: @result
  end
=end
end