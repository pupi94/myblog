# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles, id: :uuid do |t|
      t.references :user, type: :uuid
      t.string   :title
      t.integer  :pageview, limit: 4, default: 0
      t.boolean  :published, default: false
      t.datetime :published_at
      t.text     :content
      t.text     :html_content
      t.timestamps
    end
  end
end
