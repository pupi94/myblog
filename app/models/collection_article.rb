# frozen_string_literal: true

class CollectionArticle < ApplicationRecord
  belongs_to :article, dependent: :destroy
  belongs_to :collection, dependent: :destroy
end
