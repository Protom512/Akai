class AddUserIdToNovel < ActiveRecord::Migration[5.0]
  def change
     add_column :novels, :user_id, :integer
  end
end
