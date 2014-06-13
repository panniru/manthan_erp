class RenamePaymentDetailIdToTermDefinitionIdParentPaymentTransactions < ActiveRecord::Migration
  def change
    rename_column :parent_payment_transactions, :term_definition_id, :term_definition_id
  end
end
