class CreatePayslips < ActiveRecord::Migration
  def change
    create_table :payslips do |t|
      t.integer :faculty_master_id
      t.date :generated_date
      t.integer :basic
      t.integer :hra
      t.integer :conveyance_allowance
      t.integer :city_compensatory_allowance
      t.integer :special_allowance
      t.integer :loyalty_allowance
      t.integer :medical_allowance
      t.integer :arrears_of_salary
      t.integer :incentive_payment
      t.integer :loyalty_deposit
      t.integer :grade_allowance
      t.integer :leave_settlement
      t.integer :performance_bonus
      t.integer :annual_bonus
      t.integer :additional_allowance_1
      t.integer :additional_allowance_2
      t.integer :additional_allowance_3
      t.integer :pf
      t.integer :club_contribution
      t.integer :professional_tax
      t.integer :tds_pm
      t.integer :training_cost
      t.integer :salary_advance
      t.integer :additional_deduction_1
      t.integer :additional_deduction_2
      t.integer :additional_deduction_3
      t.integer :notice_period_amount
      t.integer :labour_welfare_fund
      t.integer :voluntary_pf_contribution
      t.string :status

      t.timestamps
    end
  end
end
