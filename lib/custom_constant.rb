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
  
  SEARCH_PAGE = {
    "page_size" => {
      "DEFAULT" => 15,
      "MIN" => 1
    },
    "page_no" => {
      "DEFAULT" => 0,
      "MIN" => 0
    },
    "page_count" => {
      "DEFAULT" => 1,
      "MIN" => 1
    }
  }

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
