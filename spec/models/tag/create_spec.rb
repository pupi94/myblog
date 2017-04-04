require 'rails_helper'
require 'spec_helper'

RSpec.describe Tag, type: :model do
  describe '.create' do

    let(:params) {
      {
        'name' => '标签1'
      }
    }

    it 'success' do
      rtn = Tag.create(params)
      expect_success_result rtn
      category = Tag.find_by_name(params['name'])
      expect(category).to_not be_nil
    end

    it 'name absent' do
      params['name'] = nil
      rtn = Tag.create(params)
      expect_error_result(rtn, ErrorCode::ERR_TAG_NAME_CANNOT_BE_BLANK)
    end

    it 'name exist' do
      tag = FactoryGirl.create(:tag)
      params['name'] = tag.name
      rtn = Tag.create(params)
      expect_error_result(rtn, ErrorCode::ERR_TAG_NAME_NOT_UNIQUE)
    end
  end
end
