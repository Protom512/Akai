class CreateUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :updates do |t|
      t.string :ncode
      t.integer :length
      t.integer :all_point
      t.integer :all_hyoka_cnt
      t.integer :global_point
      t.integer :fav_novel_cnt
      t.integer :review_cnt
      t.datetime :novel_updated_at

      t.timestamps
    end
  end
end
