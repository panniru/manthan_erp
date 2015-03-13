class CreatePfStatements < ActiveRecord::Migration
  def change
    create_table :pf_statements do |t|
      t.integer :faculty_master_id
      t.integer :payslip_id
      t.integer :epf_wages
      t.integer :eps_wages
      t.integer :epf_ee_share
      t.integer :epf_ee_remitted
      t.integer :eps_due
      t.integer :eps_remitted
      t.integer :diff_epf_and_eps
      t.integer :diff_remitted
      t.integer :n
      t.integer :refund_adv, :default => 0
      t.integer :arrear_epf, :default => 0
      t.integer :arrear_epf_ee, :default => 0
      t.integer :arrear_epf_er, :default => 0
      t.integer :arrear_eps, :default => 0
      t.integer :job_run_id
      t.timestamps
    end
  end
end
