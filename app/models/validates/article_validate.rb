module Validates
  module ArticleValidate
    extend ModelValidate

    attr_validates do
      validates_presence_of :title,       message: 'article.error.title_blank'
      validates_presence_of :source_type, message: 'article.error.source_type_blank'
      validates_presence_of :category_id, message: 'article.error.category_id_blank'
      validates_presence_of :tags,        message: 'article.error.tags_blank'

      validates :title,      length: { maximum: 64, message: 'article.error.title_length_over_64' }
      validates :source,     length: { maximum: 64, message: 'article.error.source_length_over_64' }
      validates :source_url, length: { maximum: 128, message: 'article.error.source_url_length_over_128' }
      validates :summary,    length: { maximum: 255, message: 'article.error.summary_length_over_255' }

      validates(:tags,
        length: { maximum: 64,  message: 'article.error.tags_length_over_64' },
        format: { with: /\A([-a-zA-Z\u4E00-\u9FFF\s](,)?)+\Z/, message: 'article.error.tags_invalid' }
      )

      validates :source_type,  inclusion: {in: SourceType.const_values, message: 'article.error.source_type_invalid'}
      validates :status,    inclusion: {in: ArticleStatus.const_values, message: 'article.error.status_invalid'}
    end
  end
end
