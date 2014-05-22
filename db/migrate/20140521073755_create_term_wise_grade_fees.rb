class CreateTermWiseGradeFees < ActiveRecord::Migration
  def change
    create_table :term_wise_grade_fees do |t|
      t.integer :fee_grade_bucket_id
      t.integer :term_definition_id
      t.integer :amount_in_rupees
      t.string :academic_year

      t.timestamps
    end
  end
end
