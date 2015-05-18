class AddFieldToFinalResult < ActiveRecord::Migration
  def change
    add_column :final_results, :assessment_grade_mapping_id, :integer
  end
end
