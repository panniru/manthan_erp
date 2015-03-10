class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.integer :assessment_grade_mapping_id
      t.integer :subject_master_id

      t.timestamps
    end
  end
end
