class Article < ApplicationRecord
  include MarkdownTool
  include Validates::ArticleValidate

  belongs_to :category
  belongs_to :user, foreign_key: "author_id"

  scope :published, -> { enabled.where(status: ArticleStatus::PUBLISHED) }
  scope :category_filter, ->(category_id) { where(category_id: category_id) if category_id.present? }
  scope :title_filter, ->(title) do
    title = title&.strip
    where('title like ?', "%#{title}%") if title.present?
  end

  before_save :update_content_html
  def update_content_html
    self.content_html = convert_html(self.content)
  end

  def publish
    fail CustomError.new('article.error.article_can_not_edit') unless self.enabled

    if ArticleStatus::EDITING == self.status
      self.status = ArticleStatus::PUBLISHED
      self.pubdate = Time.current
      self.save
    end
  end

  class << self
    def search(params, enabled: true, order_by: :created_at)
      articles = enabled ? self.enabled : self.disabled

      articles = articles.where(status: params['status']) if params['status'].present?
      articles = articles.category_filter(params['category']).title_filter(params['title'])

      if params['wd'].present? && params['wd'] != ','
        articles = articles.where(
          'title like :search_text or summary like :search_text or tags like :search_text',
          search_text: "%#{params['wd'].strip}%"
        )
      end

      total_count = articles.size
      return nil, 0 if total_count == 0

      articles = articles.order("#{order_by} desc").page_filter(params['page_size'], params['page'])
      search_column = %w[id title category_id summary source_type tags pv pubdate status created_at]
      articles = articles.select(*search_column).as_json
      return articles, total_count
    end

    def common_tags
      tag_hash = Hash.new(0)
      self.published.pluck(:tags).each do |tag_str|
        tag_str.split(',').each do |tag|
          tag_hash[tag] += 1
        end
      end
      tag_hash.to_a.sort {|a, b| a[1] > b[1] ? -1 : 1}.slice(0, 5).map{|tag| tag[0]}
    end
  end
end