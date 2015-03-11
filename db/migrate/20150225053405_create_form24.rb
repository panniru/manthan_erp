class CreateForm24 < ActiveRecord::Migration
  def change
    create_table :form24s do |t|
      t.integer :quarter
      t.string :financial_year
      t.string :cheque_no
      t.date :created_date
      t.string :emp_status
      t.integer :month
      t.integer :year
      t.date :deposited_date
      t.string :challan_serial_no
      t.string :bsr_code
      t.string :payment_type
     
      t.timestamps
    end
  end
end
