class AddLongitudeToLocationMaster < ActiveRecord::Migration
  def change
    add_column :location_masters, :longitude, :float
  end
end
