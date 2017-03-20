class AddColumnToNovels < ActiveRecord::Migration[5.0]
  def change
    add_column :novels,:novel_type,:integer
    add_column :updates,:general_all_no ,:integer
  end
end
