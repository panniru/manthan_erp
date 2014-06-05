class CreateParentPdcs < ActiveRecord::Migration
  def change
    create_table :parent_pdcs do |t|
      t.integer :parent_payment_master_id
      t.integer :parent_payment_transaction_id
      t.integer :amount_in_rupees
      t.string :cheque_number
      t.date :clearence_date
      t.string :status
      t.integer :post_dated_cheque_id

      t.timestamps
    end
  end
end
