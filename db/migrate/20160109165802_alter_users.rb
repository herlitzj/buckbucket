class AlterUsers < ActiveRecord::Migration
  def change
    change_column :users, :provider, :string, null: false
    change_column :users, :uid, :string, null: false
    add_index :users, :provider
    add_index :users, :uid
    add_index :users, [:provider, :uid], unique: true
  end
end
