class CreateAssessmentTeacherMappings < ActiveRecord::Migration
  def change
    create_table :assessment_teacher_mappings do |t|
      t.integer :faculty_master_id
      t.integer :grade_master_id
      t.integer :section_master_id
      t.integer :assessment_type_id

      t.timestamps
    end
  end
end
