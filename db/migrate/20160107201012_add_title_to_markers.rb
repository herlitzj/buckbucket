class AddTitleToMarkers < ActiveRecord::Migration
  def change
    add_column :markers, :title, :string
  end
end
