class AddStatusToParentPaymentTransactions < ActiveRecord::Migration
  def change
    add_column :parent_payment_transactions, :status, :string
  end
end
