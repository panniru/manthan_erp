class AddPaymentDetailIdToParentPaymentTransactions < ActiveRecord::Migration
  def change
    add_column :parent_payment_transactions, :payment_detail_id, :integer
  end
end
