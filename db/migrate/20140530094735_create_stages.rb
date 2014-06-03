class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :enquiry_submission
      t.string :application_issued
      t.string :application_submission
      t.string :assessment_scheduled
      t.string :assessment_completed
      t.string :management_review
      t.string :declaration

      t.timestamps
    end
  end
end
