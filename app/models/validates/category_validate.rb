module Validates
  module CategoryValidate
    extend ModelValidate

    attr_validates do
      validates_presence_of :name
      validates_presence_of :name_en

      validates :name, length: { maximum: 32 }, uniqueness: { case_sensitive: false }
      validates :name_en, length: { maximum: 32 },
        uniqueness: { case_sensitive: false },
        format: { with: /\A[-A-Za-z0-9_]+\Z/ }
    end
  end
end
