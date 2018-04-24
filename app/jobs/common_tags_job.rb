class CommonTagsJob
  include Sidekiq::Worker

  sidekiq_options retry: false, queue: SidekiqQueue::DEFAULT

  def perform
    tags = Article.common_tags
    Rails.cache.write('common_tags', tags)
  end
end


#CommonTagsJob.perform_in(3.hours, 'mike', 1) 三小时后执行
#CommonTagsJob.perform_at(3.hours.from_now, 'mike', 1)
# {
#   'name'  => 'name_of_job', #must be uniq!
#   'cron'  => '1 * * * *',  # execute at 1 minute of every hour, ex: 12:01, 13:01, 14:01, 15:01...etc(HH:MM)
#   'class' => 'MyClass',
#   #OPTIONAL
#   'queue' => 'name of queue',
#   'args'  => '[Array or Hash] of arguments which will be passed to perform method',
#   'active_job' => true,  # enqueue job through rails 4.2+ active job interface
#   'queue_name_prefix' => 'prefix', # rails 4.2+ active job queue with prefix
#   'queue_name_delimiter' => '.'  # rails 4.2+ active job queue with custom delimiter
# }
#Sidekiq::Cron::Job.create(name: 'Hard worker - every 5min', cron: '*/5 * * * *', class: 'CommonTagsJob') # execute at every 5 minutes
# => true
