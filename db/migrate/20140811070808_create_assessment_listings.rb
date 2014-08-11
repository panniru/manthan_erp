class CreateAssessmentListings < ActiveRecord::Migration
  def change
    create_table :assessment_listings do |t|
      t.integer :faculty_master_id
      t.integer :grade_master_id
      t.integer :section_master_id
      t.integer :subject_master_id
      t.integer :assessment_type_id
      t.string :assessment_desc
      t.date :assessment_date

      t.timestamps
    end
  end
end
