class CreateNovels < ActiveRecord::Migration[5.0]
  def change
    create_table :novels do |t|
      t.string :ncode
      t.string :title
      t.text :story
      t.integer :genre
      t.integer :big_genre
      t.timestamps
    end
  end
end
