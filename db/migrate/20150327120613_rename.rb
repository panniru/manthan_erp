class Rename < ActiveRecord::Migration
  def change
 rename_column :lab_subject_assessments, :lab_assessment_id, :lab_assessment_grade_mapping_id
  end
end
