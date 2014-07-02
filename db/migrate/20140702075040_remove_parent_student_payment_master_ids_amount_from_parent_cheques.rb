class RemoveParentStudentPaymentMasterIdsAmountFromParentCheques < ActiveRecord::Migration
  def change
    remove_column :parent_cheques, :parent_id
    remove_column :parent_cheques, :student_id
    remove_column :parent_cheques, :parent_payment_master_id
    remove_column :parent_cheques, :amount_in_rupees
  end
end
