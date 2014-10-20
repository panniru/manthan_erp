class AddFacultyMasterIdAndRoleIdToStaffadmin < ActiveRecord::Migration
  def change
    add_column :staffadmins, :faculty_master_id, :integer
    add_column :staffadmins, :role_id, :integer
  end
end
