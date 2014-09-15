class AddInventoryTypeToInventories < ActiveRecord::Migration
  def change
    add_column :inventories, :inventory_type, :string
  end
end
