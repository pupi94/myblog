# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.configuration.settings["redis"]["sidekiq"] }
  # 异常处理
  # config.error_handlers << Proc.new {|ex,ctx_hash| MyErrorService.notify(ex, ctx_hash) }

  config.death_handlers << lambda { |job, ex|
    puts "Uh oh, #{job['class']} #{job['jid']} just died with error #{ex.message}."
  }

  # 每半小时检查一次新作业
  # config.average_scheduled_poll_interval = 30*60
  config.average_scheduled_poll_interval = 5

  schedule_file = "config/schedule.yml"
  if File.exist?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_SIDEKIQ"] }
end

# 设置默认的参数
# Sidekiq.default_worker_options = { 'backtrace' => true }
