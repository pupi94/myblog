class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :label, type: :integer
      t.references :user, type: :integer
      t.string   :title,          null: false, limit: 64
      t.string   :summary,        null: true,  limit: 255
      t.integer  :pv,             null: false, limit: 4, default: 0
      t.string   :status,         null: false, limit: 16
      t.datetime :pubdate,        null: true
      t.text     :body
      t.text     :body_html
      t.boolean  :enabled,        null: false, default: true
      t.timestamps null: false
    end
  end
end
