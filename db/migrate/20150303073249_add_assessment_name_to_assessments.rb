class AddAssessmentNameToAssessments < ActiveRecord::Migration
  def change
  	add_column :assessments, :assessment_name, :string
  end
end
