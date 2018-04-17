require 'rails_helper'
require_relative "#{HELPER_PATH}/validate_helper"

RSpec.describe Category, type: :model do
  describe '.validate' do
    include ValidateHelper

    let(:category) { create(:category) }

    it 'success' do
      expect(category).to be_present
    end

    context 'present' do
      [
        ['name',  'category.error.name_blank' ],
        ['seq',   'category.error.seq_blank']
      ].each do |value|
        it value do
          valid_column_present category, *value
        end
      end
    end

    context 'length' do
      [
        ['name', 32, 'category.error.name_length_over_32']
      ].each do |value|
        it value do
          valid_column_length category, *value
        end
      end
    end
  end
end
