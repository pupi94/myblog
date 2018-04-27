class Article < ApplicationRecord
  include MarkdownTool
  include Validates::ArticleValidate

  belongs_to :category

  belongs_to :user, foreign_key: "author_id"

  before_save :update_content_html
  def update_content_html
    self.content_html = convert_html(self.content)
  end

  def update_status
    fail CustomError.new('article.error.article_can_not_edit') unless self.enabled

    if [ArticleStatus::EDITING, ArticleStatus::SOLD_OUT].include?(self.status)
      self.status = ArticleStatus::PUBLISHED
      self.pubdate = Time.now
    else
      self.status = ArticleStatus::SOLD_OUT
    end
    self.save
  end

  class << self
    def search_for_admin(params)
      articles = self.all
      articles = (params.has_key?('enabled') && false == params['enabled']) ? articles.disabled : articles.enabled
      articles = articles.where(category_id: params['category']) if params['category'].present?
      articles = articles.where(status: params['status']) if params['status'].present?
      params['title'] = params['title'].strip if params['title'].present?
      articles = articles.where('title like ?', "%#{params['title']}%") if params['title'].present?

      total_count = articles.size
      return nil, total_count if total_count == 0

      articles = articles.order(created_at: :desc).page_filter(params['page_size'], params['page'])

      search_column = %w[id title source_type tags pv pubdate status created_at]
      articles = articles.select(*search_column)
      return articles, total_count
    end

    def search params
      articles = self.where(status: ArticleStatus::PUBLISHED)
      articles = articles.where(category_id: params['category_id']) if params['category_id'].present?
      total_count = articles.size
      return nil, 0 if total_count == 0
      articles = articles.order(pubdate: :desc)
      articles = articles.page_filter(params['page_size'], params['page'])
      articles = articles.select(*%w[id category_id summary title pv pubdate])
      return articles, total_count
    end

    def common_tags
      tag_hash = Hash.new(0)
      self.all.enabled.pluck(:tags).each do |tag_str|
        tag_str.split(',').each do |tag|
          tag_hash[tag] += 1
        end
      end
      tag_hash.to_a.sort {|a, b| a[1] > b[1] ? -1 : 1}.slice(0, 5).map{|tag| tag[0]}
    end
  end
end