class AddRouteIdToLocationMaster < ActiveRecord::Migration
  def change
    add_column :location_masters, :route_id, :integer
  end
end
