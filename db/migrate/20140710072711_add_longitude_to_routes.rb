class AddLongitudeToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :longitude, :float
  end
end
