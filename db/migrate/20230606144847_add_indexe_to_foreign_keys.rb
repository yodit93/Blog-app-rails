class AddIndexeToForeignKeys < ActiveRecord::Migration[7.0]
  def change
    add_index :comments, :user_id
    add_index :comments, :post_id
    add_index :posts, :user_id
    add_index :likes, :user_id
    add_index :likes, :post_id
  end
end
