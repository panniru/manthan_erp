class AddAssessmentResultToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :assessment_result, :string
  end
end
