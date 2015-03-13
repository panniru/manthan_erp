class CreatePayslipAdditionalFieldsLabels < ActiveRecord::Migration
  def change
    create_table :payslip_additional_fields_labels do |t|
      t.integer :payslip_id
      t.string :additional_allowance_1
      t.string :additional_allowance_2
      t.string :additional_allowance_3
      t.string :additional_deduction_1
      t.string :additional_deduction_2
      t.string :additional_deduction_3
    end
  end
end
