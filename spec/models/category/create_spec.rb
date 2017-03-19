require 'rails_helper'
require 'spec_helper'

RSpec.describe Category, type: :model do
  describe '.create' do

    let(:params) {
      {
        'name' => '类别一'
      }
    }

    it 'success' do
      rtn = Category.create(params)
      expect_success_result rtn
      category = Category.find_by_name(params['name'])
      expect(category).to_not be_nil
      expect(category.seq).to eq Category.all.size - 1
    end

    it 'name absent' do
      params.delete('name')
      rtn = Category.create(params)
      expect_error_result(rtn, ErrorCode::ERR_CATEGORY_NAME_CANNOT_BE_BLANK)
    end

    it 'name exist' do
      category = FactoryGirl.create(:category)
      params['name'] = category.name
      rtn = Category.create(params)
      expect_error_result(rtn, ErrorCode::ERR_CATEGORY_NAME_NOT_UNIQUE)
    end
  end
end
