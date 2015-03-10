class AddAssessmentIdToAssessmentCriteria < ActiveRecord::Migration
  def change
  	remove_column :assessment_criteria, :subject_master_id, :integer
  	remove_column :assessment_criteria, :grade_master_id, :integer
  	remove_column :assessment_criteria, :subject_criteria, :integer
  	
  	add_column :assessment_criteria, :assessment_id, :integer
  	add_column :assessment_criteria, :assessment_criteria, :string
  end
end
