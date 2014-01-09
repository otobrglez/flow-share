class AddFullNameAndAliasToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string, null: true
    add_column :users, :username, :string, null: false

    add_index :users, :username, unique: true
  end
end
