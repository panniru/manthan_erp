class CreateLabSubjectAssessments < ActiveRecord::Migration
  def change
    create_table :lab_subject_assessments do |t|
      t.integer :lab_assessment_id
      t.integer :subject_master_id
      t.string :assessment_name

      t.timestamps
    end
  end
end
