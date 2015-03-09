class AddStaffadminIdToStaffrecruits < ActiveRecord::Migration
  def change
    add_column :staffrecruits, :staffadmin_id, :integer
  end
end
