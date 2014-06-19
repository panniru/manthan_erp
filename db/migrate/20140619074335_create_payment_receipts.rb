class CreatePaymentReceipts < ActiveRecord::Migration
  def change
    create_table :payment_receipts do |t|
      t.string :code
      t.integer :parent_payment_transaction_id

      t.timestamps
    end
  end
end
