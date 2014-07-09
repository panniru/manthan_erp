class ChangeDataTypesInTeacherGradeMappings < ActiveRecord::Migration
  def change  
   change_column :teacher_grade_mappings, :grade_master_id, 'integer USING CAST(grade_master_id AS integer)'
   change_column :teacher_grade_mappings, :section_master_id, 'integer USING CAST(section_master_id AS integer)'
   change_column :teacher_grade_mappings, :subject_master_id, 'integer USING CAST(subject_master_id AS integer)'
  end  
end
