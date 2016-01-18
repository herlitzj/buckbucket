class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.string :venmo_access_token
      t.string :venmo_refresh_token
      t.string :expires
      t.datetime :expires_on
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
