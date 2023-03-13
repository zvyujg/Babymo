class CreateArtcles < ActiveRecord::Migration[6.1]
  def change
    create_table :artcles do |t|
      t.integer :user_id
      t.string :title, null: false
      t.text :content, null: false
      t.string :image_id
      t.integer :rate, default: 3
      t.integer :difficulty, default: 3
      t.integer :length, default: 3
      t.integer :practicality, default: 3
      t.integer :speed, default: 3
      t.integer :accent, default: 3

      t.timestamps
    end
  end
end
