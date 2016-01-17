class CreateClaimedMarkers < ActiveRecord::Migration
  def change
    create_table :claimed_markers do |t|
      t.integer :marker_id, null: false
      t.integer :owner_id, null: false
      t.integer :claimer_id, null: false

      t.timestamps null: false
    end
  end
end
