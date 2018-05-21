class SyncArticlePvJob
  include Sidekiq::Worker

  sidekiq_options retry: false, queue: SidekiqQueue::DEFAULT

  def perform
    Article.published.each do |article|
      key = "article::#{article.id}::pv"
      pv = BlogRedis.pfcount(key)
      next if pv == 0
      article.pv += pv
      article.save
      BlogRedis.del(key)
    end
  end
end