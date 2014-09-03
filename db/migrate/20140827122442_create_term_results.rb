class CreateTermResults < ActiveRecord::Migration
  def change
    create_table :term_results do |t|
      t.integer :academic_term_id
      t.integer :grade_master_id
      t.integer :section_master_id
      t.integer :student_master_id
      t.integer :assessment_criteria_id
      t.integer :grading_master_id

      t.timestamps
    end
  end
end
