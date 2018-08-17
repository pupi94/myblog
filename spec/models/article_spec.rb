require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '.validate' do

    let(:article) { build(:articles) }

    it "be valid" do
      expect(article).to be_valid
    end

    context "presence" do
      %i[title source_type category_id tags].each do |column_name|
        it { should validate_presence_of(column_name) }
      end
    end

    context "length" do
      %i[title source tags].each do |column_name|
        it { should validate_length_of(column_name).is_at_most(32) }
      end

      it { should validate_length_of(:source_url).is_at_most(128) }
      it { should validate_length_of(:summary).is_at_most(255) }
    end
  end
end
