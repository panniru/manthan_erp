class AddStatusToNewVehicle < ActiveRecord::Migration
  def change
    add_column :new_vehicles, :status, :string
  end
end
