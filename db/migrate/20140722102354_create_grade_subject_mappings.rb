class CreateGradeSubjectMappings < ActiveRecord::Migration
  def change
    create_table :grade_subject_mappings do |t|
      t.integer :subject_master_id
      t.integer :grade_master_id

      t.timestamps
    end
  end
end
