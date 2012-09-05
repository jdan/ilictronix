class CreateRolesUsers < ActiveRecord::Migration
  def up
    create_table :roles_users, :id => false do |t|
      t.references :user, :role
    end
  end

  def down
    drop_table :roles_users
  end
end
