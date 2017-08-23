class AttachmentController < ApplicationController

  def download
    begin
      file_path = params['file_path']
      file_name = file_path.split('/').last
      file_type = file_name.split('.').last
      #result = FileLoadByAliyun.download(file_path)
      result = {'return_code' => 0, 'return_info' => 'success'}
      if result["return_code"] == 0
        send_data result["return_info"], :type => file_type.to_sym.downcase, :filename => URI.decode(file_name), :disposition => "inline"
      else
        Log.error "download file failed: params[#{params}], result[#{result}]"
      end
    rescue Exception => e
      Log.error e
    end
  end

  # service_name:    附件所属对象所在服务的名称简写
  # attachment_type: 附件类型
  # attachment_id:   附件所属对象id, 如果所属对象还未创建，可以使当前用户id
  # object_name:       附件存储表名
  # object_id:       附件存储表，标识ID
  def update
    result = {'return_code' => 0, 'return_info' => 'success'}
    begin
      attachment_type = params['attachment_type']
      attachment_id = params['attachment_id']
      attachment_name = params['attachment_name'].present? ? params['attachment_name'] : DateTime.now.strftime("%Y%m%d%H%M%S") # 临时文件夹
      object_name = params['object_name']
      object_id = params['object_id']

      if params["upload_attachment"].present?
        attachment_path = ""
        FileUtils.mkdir("#{Rails.root}/public/upload") unless File.exist?("#{Rails.root}/public/upload")
        params["upload_attachment"].each do |attachment|
          filename = DateTime.now.strftime("%Y%m%d%H%M%S") << attachment.original_filename
          File.open(Rails.root.join('public', 'uploads', filename), 'wb') do |file|
            file.write(attachment.read)
          end
          attachment_path << "uploads/#{filename}-||-"
        end
        result["attachment"] = attachment_path
      end
    end
    render json: result
  end
end