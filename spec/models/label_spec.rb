# frozen_string_literal: true

require "rails_helper"

RSpec.describe Label, type: :model do
  describe ".validate" do
    let(:instance) { build(:label) }

    it "be valid" do
      expect(instance).to be_valid
    end

    context "presence" do
      it { should validate_presence_of(:name).with_message("can't be blank") }
    end

    context "length" do
      it { should validate_length_of(:name).is_at_most(32).with_message("is too long (maximum is 32 characters)") }
    end

    context "length" do
      let(:label) { create(:label) }

      it { should_not allow_value(label.name).for(:name).with_message("has already been taken)") }
    end
  end
end
