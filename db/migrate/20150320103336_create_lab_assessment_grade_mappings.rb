class CreateLabAssessmentGradeMappings < ActiveRecord::Migration
  def change
    create_table :lab_assessment_grade_mappings do |t|
      t.integer :assessment_type_id
      t.integer :grade_master_id
      t.integer :no_of_times

      t.timestamps
    end
  end
end
