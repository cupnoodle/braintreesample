class AddTwitterTokenToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :oauth_token, :string
    add_column :users, :username, :string, null: false, default: ""

    add_index :users, :username, unique: true
  end

  def down
    remove_column :users, :oauth_token
    remove_column :users, :username

    remove_index :users, :username
  end
end
