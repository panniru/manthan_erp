class CreateParentPaymentTransactions < ActiveRecord::Migration
  def change
    create_table :parent_payment_transactions do |t|
      t.integer :parent_payment_master_id
      t.date :transaction_date
      t.integer :amount_in_rupees
      t.string :transaction_type
      t.string :particulars
      t.string :academic_year

      t.timestamps
    end
  end
end
