module RedisHelper
  extend ActiveSupport::Concern

  def redis_client
    @redis_client ||= Redis.new(url: ENV["REDIS_CACHE"])
  end
end