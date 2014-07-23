class AddLocationToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :location, :string
  end
end
