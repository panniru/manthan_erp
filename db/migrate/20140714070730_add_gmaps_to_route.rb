class AddGmapsToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :gmaps, :boolean
  end
end
