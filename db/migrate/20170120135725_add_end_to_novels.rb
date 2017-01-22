class AddEndToNovels < ActiveRecord::Migration[5.0]
  def change
    add_column :novels ,:ends ,:integer
  end
end
