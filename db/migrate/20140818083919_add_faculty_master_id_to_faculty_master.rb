class AddFacultyMasterIdToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :faculty_master_id, :integer
  end
end
