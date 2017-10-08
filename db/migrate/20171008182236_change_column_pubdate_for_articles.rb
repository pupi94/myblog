class ChangeColumnPubdateForArticles < ActiveRecord::Migration[5.0]
  def up
    change_column :articles, :pubdate, :datetime
  end

  def down
    change_column :articles, :pubdate, :date
  end
end
