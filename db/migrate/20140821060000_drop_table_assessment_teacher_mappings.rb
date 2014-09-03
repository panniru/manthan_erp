class DropTableAssessmentTeacherMappings < ActiveRecord::Migration
  def change
  	drop_table :assessment_teacher_mappings
  end
end
