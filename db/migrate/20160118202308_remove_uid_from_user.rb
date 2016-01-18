class RemoveUidFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :uid
    remove_column :users, :provider
    remove_column :users, :venmo_token
    remove_column :users, :venmo_refresh_token
  end
end
