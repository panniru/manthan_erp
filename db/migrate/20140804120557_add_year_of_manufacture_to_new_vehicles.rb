class AddYearOfManufactureToNewVehicles < ActiveRecord::Migration
  def change
    add_column :new_vehicles, :year_of_manufacture, :string
  end
end
