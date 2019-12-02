class CreateCollectionArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :collection_articles, id: :uuid do |t|
      t.references :article, type: :uuid
      t.references :collection, type: :uuid
      t.integer :position
      t.timestamps
    end
  end
end
