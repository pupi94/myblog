# frozen_string_literal: true

require "rails_helper"

RSpec.describe CollectionArticle, type: :model do
  describe "association" do
    it { should belong_to(:article) }
    it { should belong_to(:collection) }
  end
end
