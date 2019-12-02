# frozen_string_literal: true

module StringExtensions
  refine String do
    def to_boolean(default: false)
      s = self.downcase
      return true if s == "true"
      return false if s == "false"
      default
    end
  end
end
