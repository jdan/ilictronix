class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author
      t.string :title
      t.string :post_type
      t.text :content
      t.integer :score, :default => 0

      t.timestamps
    end
  end
end
