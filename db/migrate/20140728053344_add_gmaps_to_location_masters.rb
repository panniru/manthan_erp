class AddGmapsToLocationMasters < ActiveRecord::Migration
  def change
    add_column :location_masters, :gmaps, :boolean
  end
end
