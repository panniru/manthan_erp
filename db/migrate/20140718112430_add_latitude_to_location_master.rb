class AddLatitudeToLocationMaster < ActiveRecord::Migration
  def change
    add_column :location_masters, :latitude, :float
  end
end
