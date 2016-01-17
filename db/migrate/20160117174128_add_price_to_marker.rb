class AddPriceToMarker < ActiveRecord::Migration
  def change
    add_column :markers, :price, :decimal, precision: 5, scale: 2
  end
end
