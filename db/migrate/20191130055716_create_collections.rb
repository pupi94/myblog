class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections, id: :uuid do |t|
      t.references :user, type: :uuid
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
