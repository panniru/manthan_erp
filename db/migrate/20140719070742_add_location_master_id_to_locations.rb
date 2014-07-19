class AddLocationMasterIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :location_master_id, :integer
  end
end
