require 'rails_helper'
require 'spec_helper'

RSpec.describe Category, type: :model do
  describe '.create' do

    let(:params) {
      ActionController::Parameters.new(name: '类别一')
    }

    it 'success' do
      rtn = Category.create(params)
      expect(rtn).to be_success
      category = Category.find_by_name(params['name'])
      expect(category).to_not be_nil
      expect(category.seq).to eq Category.all.size - 1
    end

    it 'name absent' do
      params.delete('name')
      rtn = Category.create(params)
      expect(rtn).to be
      expect(rtn).to has_code ErrorCode::ERR_CATEGORY_NAME_CANNOT_BE_BLANK
    end

    it 'name exist' do
      category = create(:category)
      params['name'] = category.name
      rtn = Category.create(params)
      expect(rtn).to has_code ErrorCode::ERR_CATEGORY_NAME_NOT_UNIQUE
    end
  end
end
