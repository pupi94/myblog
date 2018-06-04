module CustomConstant
  module ConstantValue
    def const_values
      result = []
      self.constants.each {|constant_key| result << self.const_get(constant_key)}
      result
    end
  end

  DEFAULT_PAGE_SIZE = 15.freeze
  DEFAULT_PAGE = 1.freeze
  ARTICLE_PAGE_SIZE = 10

  SUCCESS_CODE = 0

  module SourceType
    extend ConstantValue
    ORIGINA = 'original'.freeze
    REPRINT = 'reprint'.freeze
    TRANSLATE = 'translate'.freeze
  end

  module ArticleStatus
    extend ConstantValue
    EDITING = "editing".freeze
    PUBLISHED = "published".freeze
  end

  module BlogLayout
    DEVISE = 'devise'.freeze
    ADMIN = 'admin'.freeze
    APPLICATION = 'application'.freeze
  end

  module SidekiqQueue
    CRITICAL = 'critical'
    DEFAULT = 'default'
    LOW = 'low'
  end
end
