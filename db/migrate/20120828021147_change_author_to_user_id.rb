class ChangeAuthorToUserId < ActiveRecord::Migration
  def up
    remove_column :posts, :author
    add_column :posts, :user_id, :integer
  end

  def down
    remove_column :posts, :user_id
    add_column :posts, :author, :integer
  end
end
