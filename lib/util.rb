module Util
  # 捕获异常块
  def self.try_rescue(&block)
    response = CommonException.new(ErrorCode::SUCCESS).result
    begin
      yield(response) if block_given?
    rescue CustomException => e
      Log.error e.result
      response = e.result
    rescue Exception => e
      Log.error e
      response = UndifineException.new(e.message).result
    end
    return response.as_json
  end

  def self.success?(params)
    params.present? && params['return_code'] == ErrorCode::SUCCESS
  end
end