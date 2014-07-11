class AddDeletedAtToNewVehicle < ActiveRecord::Migration
  def change
    add_column :new_vehicles, :deleted_at, :datetime
    add_index :new_vehicles, :deleted_at
  end
end
