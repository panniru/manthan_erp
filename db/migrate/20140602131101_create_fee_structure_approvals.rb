class CreateFeeStructureApprovals < ActiveRecord::Migration
  def change
    create_table :fee_structure_approvals do |t|
      t.string :approved_by
      t.string :defined_by
      t.string :status
      t.string :academic_year

      t.timestamps
    end
  end
end
