class CreateMonthlyPdcAmounts < ActiveRecord::Migration
  def change
    create_table :monthly_pdc_amounts do |t|
      t.integer :fee_grade_bucket_id
      t.integer :post_dated_cheque_id
      t.integer :amount_in_rupees
      t.string :academic_year

      t.timestamps
    end
  end
end
