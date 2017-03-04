module Util
  # 捕获异常块
  def self.try_rescue(&block)
    response = CommonException.new(ErrorCode::SUCCESS).result
    begin
      yield(response) if block_given?
    rescue CustomException => e
      Log.error e
      response = e.result
    rescue Exception => e
      Log.error e
      response = UndifineException.new(e.message).result
    end
    return response.as_json
  end

  # 检查并初始化分页参数
  def self.check_search_page(params)
    SEARCH_PAGE.each do |key, value|
      params[key] = value['DEFAULT'] if params[key].blank? || params[key].to_i < value['MIN']
    end
    params
  end
end