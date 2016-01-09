class AddLatLonToMarkers < ActiveRecord::Migration
  def change
    add_column :markers, :lat, :float
    add_column :markers, :lon, :float
    add_column :markers, :description, :text
  end
end
