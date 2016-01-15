class AddVenmoColumnsToUserTable < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :venmo_token, :string
    add_column :users, :venmo_refresh_token, :string
  end
end
