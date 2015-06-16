class AddResultTypeToAssessmentResults < ActiveRecord::Migration
  def change
    add_column :assessment_results, :result_type, :string
  end
end
