class AddNewVehicleIdToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :new_vehicle_id, :integer
  end
end
