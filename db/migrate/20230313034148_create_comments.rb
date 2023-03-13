class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :article_id
      t.text :content, null: false
      t.integer :reply_to

      t.timestamps
    end
  end
end
