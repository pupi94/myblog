class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string       :title,                null: false,  limit: 64
      t.string       :type,               null: false,  limit: 16
      t.string       :source,            null: false,  limit: 64
      t.string       :source_url,      null: false,  limit: 128
      t.integer     :category_id,    null: false,  limit: 128
      t.string       :tags,                 null: false,  limit: 128
      t.string       :summary,         null: false,  limit: 128
      t.text          :content,           null: false,  limit: 128
      t.string       :attachment,     null: false,  limit: 128
      t.string       :author_id,         null: false,  limit: 128
      t.string       :author_name,   null: false,  limit: 128
      t.integer     :pv,                     null: false,  limit: 128
      t.date         :pubdate,            null: false,  limit: 128
      t.string       :status,                null: false,  limit: 128
      t.boolean   :enable,                null: false,  default: true
      t.timestamps                           null: false
    end
  end
end
