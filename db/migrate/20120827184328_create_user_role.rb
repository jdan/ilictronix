class CreateUserRole < ActiveRecord::Migration
  def up
    create_table :user_role, :id => false do |t|
      t.references :user, :role
    end
  end

  def down
    drop_table :user_role
  end
end
