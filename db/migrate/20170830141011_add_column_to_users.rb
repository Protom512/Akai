class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users,:userid,:integer
    add_index :users,:userid
    add_index :updates,[:ncode,:novel_updated_at],:unique => true
    users=User.all
    users.each do |user|
      user.userid=user.id
      user.save!
    end
    
  end
  def down
    remove_column :users,:userid,:integer
    remove_index :users,:userid
  end
  
end
