class CreateDefaultAllowanceDeductions < ActiveRecord::Migration
  def change
    create_table :default_allowance_deductions do |t|
      t.integer :faculty_master_id
      t.integer :arrears_of_salary
      t.integer :incentive_payment
      t.integer :loyalty_deposit
      t.integer :grade_allowance
      t.integer :performance_bonus
      t.integer :additional_allowance_1
      t.integer :additional_allowance_2
      t.integer :additional_allowance_3
      t.integer :club_contribution
      t.integer :professional_tax
      t.integer :tds_pm
      t.integer :training_cost
      t.integer :training_cost
      t.integer :notice_period_amount
      t.integer :additional_deduction_1
      t.integer :additional_deduction_2
      t.integer :additional_deduction_3
      t.timestamps
    end
  end
end
