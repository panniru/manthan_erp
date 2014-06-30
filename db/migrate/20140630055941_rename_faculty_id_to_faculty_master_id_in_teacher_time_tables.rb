class RenameFacultyIdToFacultyMasterIdInTeacherTimeTables < ActiveRecord::Migration
  def change
    change_table :teachers_time_tables do |t|
      t.rename :faculty_id, :faculty_master_id
  	end
  end
end
