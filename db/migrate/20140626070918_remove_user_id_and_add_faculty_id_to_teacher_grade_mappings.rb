class RemoveUserIdAndAddFacultyIdToTeacherGradeMappings < ActiveRecord::Migration
 def change
  	change_table :teacher_grade_mappings do |t|
  	t.remove :user_id
    t.integer :faculty_master_id
	end
  end
end
