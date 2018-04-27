module Validates
  module CategoryValidate
    extend ModelValidate

    attr_validates do
      validates_presence_of :name, message: 'category.error.name_blank'
      validates_presence_of :name_en, message: 'category.error.name_en_blank'
      validates_presence_of :seq, message: 'category.error.seq_blank'

      validates(
        :name,
        length: { maximum: 32, message: 'category.error.name_length_over_32' },
        uniqueness: { case_sensitive: false, message: 'category.error.name_not_unique' }
      )
      validates(
        :name_en,
        length: { maximum: 32, message: 'category.error.name_en_length_over_32' },
        uniqueness: { case_sensitive: false, message: 'category.error.name_en_not_unique' },
        format: { with: /\A[-A-Za-z0-9_]+\Z/, message: 'category.error.name_en_invalid' }
      )
    end
  end
end
