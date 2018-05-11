class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
      t.string     :content,  null: false,  limit: 255
      t.timestamps null: false
    end
  end
end
