class ChangeUsersNameToUsername < ActiveRecord::Migration[5.1]
  def up
    rename_column :users, :name, :username
  end

  def down
    rename_column :users, :username, :name
  end
end
