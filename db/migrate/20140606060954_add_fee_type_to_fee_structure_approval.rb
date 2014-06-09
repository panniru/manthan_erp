class AddFeeTypeToFeeStructureApproval < ActiveRecord::Migration
  def change
    add_column :fee_structure_approvals, :fee_type, :string
  end
end
