class AddFacultyMasterIdToStaffrecruit < ActiveRecord::Migration
  def change
    add_column :staffrecruits, :faculty_master_id, :integer
  end
end
