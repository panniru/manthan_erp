class AddPaymentDetailIdToParentPaymentTransactions < ActiveRecord::Migration
  def change
    add_column :parent_payment_transactions, :term_definition_id, :integer
  end
end
