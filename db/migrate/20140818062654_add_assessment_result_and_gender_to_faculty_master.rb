class AddAssessmentResultAndGenderToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :assessment_result, :string
    add_column :faculty_masters, :gender, :string
  end
end
