class ChangeFeeStructureApprovalsToApprovalItems < ActiveRecord::Migration
  def change
    rename_table :fee_structure_approvals, :approval_items
  end
end
