class AddPaidToClaimedMarker < ActiveRecord::Migration
  def change
    add_column :claimed_markers, :paid, :boolean, default: false, null: false
  end
end
