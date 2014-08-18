class AddSubjectMasterIdAndStaffLeaderIdToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :subject_master_id, :integer
    add_column :faculty_masters, :staff_leader_id, :integer
  end
end
