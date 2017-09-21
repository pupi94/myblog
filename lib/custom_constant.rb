module CustomConstant
  module ConstantValue
    def const_values
      result = []
      self.constants.each {|constant_key| result << self.const_get(constant_key)}
      result
    end
  end

  SERVICER_ID       = 'BLOG'

  DEFAULT_PAGE_SIZE = 15
  DEFAULT_PAGE = 1

  module SourceType
    extend ConstantValue
    ORIGINA = 'original'
    REPRINT = 'reprint'
    TRANSLATE = 'translate'
  end

  module ArticleStatus
    extend ConstantValue
    EDITING = "editing"
    PUBLISHED = "published"
    SOLD_OUT = "sold_out"
  end

end
