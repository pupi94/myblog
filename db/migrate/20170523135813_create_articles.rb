# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :label, type: :integer
      t.references :user, type: :integer
      t.string   :title
      t.integer  :pageview, limit: 4, default: 0
      t.boolean  :published, default: false
      t.datetime :published_at
      t.text     :body
      t.text     :body_html
      t.timestamps
    end
  end
end
