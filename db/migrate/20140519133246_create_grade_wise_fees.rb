class CreateGradeWiseFees < ActiveRecord::Migration
  def change
    create_table :grade_wise_fees do |t|
      t.integer :fee_grade_bucket_id
      t.integer :fee_type_id
      t.integer :amount_in_rupees
      t.string :acedemic_year

      t.timestamps
    end
  end
end
