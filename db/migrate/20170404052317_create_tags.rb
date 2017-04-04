class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string          :name,            null: false,  limit: 32
      t.boolean       :enable,          null: false,  default: true
      t.timestamps                        null: false
    end
  end
end
