module CustomConstant
  module ConstantValue
    def const_values
      self.constants.reduce([]){ |values, value| values << self.const_get(value) }
    end
  end

  DEFAULT_PAGE_SIZE = 15.freeze
  DEFAULT_PAGE = 1.freeze
  ARTICLE_PAGE_SIZE = 10

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
