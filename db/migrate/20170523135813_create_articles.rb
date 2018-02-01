class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string   :title,          null: false, limit: 64
      t.string   :source_type,    null: false, limit: 16
      t.string   :source,         null: true,  limit: 64
      t.string   :source_url,     null: true,  limit: 128
      t.integer  :category_id,    null: false, limit: 4
      t.string   :tags,           null: false, limit: 64
      t.string   :summary,        null: true,  limit: 255
      t.string   :attachment,     null: true,  limit: 128
      t.integer  :author_id,      null: false, limit: 4
      t.string   :author_name,    null: false, limit: 32
      t.integer  :pv,             null: false, limit: 4, default: 0
      t.string   :status,         null: false, limit: 16
      t.boolean  :enabled,        null: false, default: true
      t.datetime :pubdate,        null: true
      t.text     :content
      t.text     :content_html
      t.timestamps null: false
    end
  end
end
