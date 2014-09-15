class AddRouteTypeToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :route_type, :string
  end
end
