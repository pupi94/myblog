module Validates
  module ArticleValidate
    extend ModelValidate

    attr_validates do
      validates_presence_of :title
      validates_presence_of :source_type
      validates_presence_of :category_id
      validates_presence_of :tags

      validates :title,      length: { maximum: 64 }
      validates :source,     length: { maximum: 64 }
      validates :source_url, length: { maximum: 128 }
      validates :summary,    length: { maximum: 255 }

      validates :tags, length: { maximum: 64}, format: { with: /\A([-a-zA-Z\u4E00-\u9FFF\s](,)?)+\Z/ }

      validates :source_type,  inclusion: {in: SourceType.const_values }
      validates :status,    inclusion: {in: ArticleStatus.const_values }
    end
  end
end
