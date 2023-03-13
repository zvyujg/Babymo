class CreateArtcleTags < ActiveRecord::Migration[6.1]
  def change
    create_table :artcle_tags do |t|
      t.integer :article_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
