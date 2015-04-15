class RenameAssessmentTypeIdInLabAssessmentGradeMapping < ActiveRecord::Migration
  def change
    rename_column :lab_assessment_grade_mappings, :assessment_type_id, :lab_assessment_id
  end
end

