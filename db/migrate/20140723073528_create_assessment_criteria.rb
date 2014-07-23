class CreateAssessmentCriteria < ActiveRecord::Migration
  def change
    create_table :assessment_criteria do |t|
      t.integer :subject_master_id
      t.integer :grade_master_id
      t.string :subject_criteria

      t.timestamps
    end
  end
end
