class AddColumnsToUnnovel < ActiveRecord::Migration[5.0]
  def change
    add_column :unnovels,:date,:date
    add_column :unnovels , :novel_id,:integer
    add_column :unnovels, :duration,:string
    add_column :unnovels,:points,:float
  end
end
