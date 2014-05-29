class CreateJobRuns < ActiveRecord::Migration
  def change
    create_table :job_runs do |t|
      t.integer :job_id
      t.timestamp :started_on
      t.timestamp :finished_on
      t.string :status
      t.string :scrolled_by
      t.date :job_date
      t.timestamps
    end
  end
end
