class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :code
      t.string :description
      t.string :job_type

      t.timestamps
    end
  end
end
