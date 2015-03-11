class CreateEmployeeAdvancePayments < ActiveRecord::Migration
  def change
    create_table :employee_advance_payments do |t|
      t.integer :faculty_master_id
      t.date :payment_date
      t.integer :amount_in_rupees
      t.string :status
      
      t.timestamps
    end
  end
end
