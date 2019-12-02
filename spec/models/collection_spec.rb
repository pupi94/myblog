# frozen_string_literal: true

require "rails_helper"

RSpec.describe Collection, type: :model do
  describe "association" do
    it { should belong_to(:user) }
    it { should have_many(:articles) }
    it { should have_many(:collection_articles) }
  end

  describe ".validate" do
    let(:collection) { build(:collection) }

    it "be valid" do
      expect(collection).to be_valid
    end

    context "presence" do
      it { should validate_presence_of(:name).with_message("can't be blank") }
    end

    context "length" do
      it { should validate_length_of(:name).is_at_most(30).with_message("is too long (maximum is 30 characters)") }
    end
  end
end
