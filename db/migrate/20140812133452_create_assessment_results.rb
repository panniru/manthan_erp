class CreateAssessmentResults < ActiveRecord::Migration
  def change
    create_table :assessment_results do |t|
      t.integer :assessment_listing_id
      t.integer :student_master_id
      t.string :assessment_result_desc

      t.timestamps
    end
  end
end
