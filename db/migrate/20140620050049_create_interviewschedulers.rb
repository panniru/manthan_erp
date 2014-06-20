class CreateInterviewschedulers < ActiveRecord::Migration
  def change
    create_table :interviewschedulers do |t|
      t.string :name
      t.string :description
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
