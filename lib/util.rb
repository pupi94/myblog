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

  # 检查并初始化分页参数
  def self.check_paging_params(params)
    SEARCH_PAGE.each do |key, value|
      params[key] = (params[key].blank? || params[key].to_i < value['MIN']) ? value['DEFAULT'] : params[key].to_i
    end
    params
  end

  def self.success?(params)
    params.present? && params['return_code'] == ErrorCode::SUCCESS
  end
end