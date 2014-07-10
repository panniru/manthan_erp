class AddLatitudeToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :latitude, :float
  end
end
