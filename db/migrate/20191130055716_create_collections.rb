class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections, id: :uuid do |t|
      t.references :user, type: :uuid
      t.string :name
      t.text :description
      t.integer :article_count, default: 0
      t.timestamps
    end
  end
end
