class CreateMedicalBills < ActiveRecord::Migration
  def change
    create_table :medical_bills do |t|
      t.integer :faculty_master_id
      t.integer :salary_tax_id
      t.integer :amount
      t.string :bill_no
      t.date :bill_date
      t.string :attachment
    end
  end
end
