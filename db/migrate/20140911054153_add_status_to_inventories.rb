class AddStatusToInventories < ActiveRecord::Migration
  def change
    add_column :inventories, :status, :string
  end
end
