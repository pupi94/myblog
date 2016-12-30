module Constant
  module ConstantValue
    def const_values
      result = []
      self.constants.each {|constant_key| result << self.const_get(constant_key)}
      result
    end
  end

  SERVICER_ID       = 'BLOG'
  DEFAULT_PAGE_SIZE = 15
end
