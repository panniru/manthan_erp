class AddIndexToTeacherGradeMappingsTable < ActiveRecord::Migration
  def change
  	add_index(:teacher_grade_mappings, [:faculty_master_id, :grade_master_id, :section_master_id, :subject_master_id], :unique => true, :name => 'teacher_grade_map_index_1')
  end
end
