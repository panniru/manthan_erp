class RenameParentIdParentMasterIdInParentPaymentMasters < ActiveRecord::Migration
  def change
    rename_column :parent_payment_masters, :parent_id, :parent_master_id
  end
end
