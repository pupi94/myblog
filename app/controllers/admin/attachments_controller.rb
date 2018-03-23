module Admin
  class AttachmentsController < ApplicationController
    def download
    end

    # object_name 附件存储表名
    def upload
      result = {'return_code' => 0, 'return_info' => 'success'}
      result['attachment'] = '/uploads/20170911052313_445601.jpg'
      p params
      render json: result
    end
  end
end