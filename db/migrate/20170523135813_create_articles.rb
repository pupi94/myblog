class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :label, type: :integer
      t.references :user, type: :integer
      t.string   :title,          null: false, limit: 64
      t.integer  :pageview,       null: false, limit: 4, default: 0
      t.boolean  :published,      null: false, default: true
      t.datetime :published_at,   null: true
      t.text     :body
      t.text     :body_html
      t.timestamps null: false
    end
  end
end
