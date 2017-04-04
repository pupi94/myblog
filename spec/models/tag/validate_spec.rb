require 'rails_helper'
require_relative "#{HELPER_PATH}/validate_helper"

RSpec.describe Tag, type: :model do
  describe '.validate' do
    include ValidateHelper

    let(:validate_object) { FactoryGirl.build(:tag) }

    it 'success' do
      expect(validate_object).to be_present
    end

    context 'present' do
      [
        ['name',   ErrorCode::ERR_TAG_NAME_CANNOT_BE_BLANK ]
      ].each do |value|
        it value do
          valid_column_present validate_object, *value
        end
      end
    end

    context 'length' do
      [
        ['name',    32,   ErrorCode::ERR_TAG_NAME_THE_MAXIMUM_LENGTH_OF_32  ]
      ].each do |value|
        it value do
          valid_column_length validate_object, *value
        end
      end
    end
  end
end
