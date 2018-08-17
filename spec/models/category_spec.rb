require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '.validate' do
    let(:instance) { build(:category) }

    it "be valid" do
      expect(instance).to be_valid
    end

    context "presence" do
      %i[name name_en].each do |column_name|
        it { should validate_presence_of(column_name) }#.with_message("Can not be blank")
      end
    end

    context "length" do
      %i[name name_en].each do |column_name|
        it { should validate_length_of(column_name).is_at_most(32)}#.with_message("Too long")
      end
    end

    context "name_en invalid" do
      it { should allow_value('ruby_test').for(:name_en) }
      it { should_not allow_value('Rails:').for(:name_en) }
    end
  end
end
