class AddAddIdToStaffadmin < ActiveRecord::Migration
  def change
    add_column :staffadmins, :add_id, :integer
  end
end
