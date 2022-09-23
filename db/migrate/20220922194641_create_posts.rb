class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.integer :comments_counter, default: 0
      t.integer :likes_counter, default: 0

      t.timestamps
    end
  end
end
