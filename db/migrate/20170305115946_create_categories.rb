class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string     :name,     null: false,  limit: 32
      t.integer    :seq,      null: false,  limit: 2
      t.boolean    :enabled,  null: false,  default: true
      t.timestamps null: false
    end
  end
end