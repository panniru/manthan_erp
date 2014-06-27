class RenameFeeTypeToTypeInApprovalItems < ActiveRecord::Migration
  def change
    rename_column :approval_items, :fee_type, :item_type
    remove_column :approval_items, :defined_by, :string
    remove_column :approval_items, :approved_by, :string
    add_column :approval_items, :defined_by, :integer
    add_column :approval_items, :approved_by, :integer
  end
end
