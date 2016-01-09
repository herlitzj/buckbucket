class AddToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :location, :string
    add_column :users, :email, :string
  end
end
