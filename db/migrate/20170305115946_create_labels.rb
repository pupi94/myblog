# frozen_string_literal: true

class CreateLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :labels, id: :uuid do |t|
      t.string     :name,     null: false,  limit: 32
      t.boolean    :enabled,  null: false,  default: true
      t.timestamps null: false
    end
  end
end
