class CreateFinalResults < ActiveRecord::Migration
  def change
    create_table :final_results do |t|
      t.integer :grade_master_id
      t.integer :assessment_type_id
      t.integer :no_of_times
      t.integer :student_master_id
      t.integer :grading_default_id
      t.string :scored_marks

      t.timestamps
    end
  end
end
