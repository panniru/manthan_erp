class CreateFeeAlertFailures < ActiveRecord::Migration
  def change
    create_table :fee_alert_failures do |t|
      t.string :e_mail
      t.integer :job_run_id
      t.string :remarks
      t.integer :parent_id

      t.timestamps
    end
  end
end
