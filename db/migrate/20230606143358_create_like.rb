class CreateLike < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :post_id
      t.datetime :UpdatedAt
      t.datetime :CreatedAt

      t.timestamps
    end
  end
end
