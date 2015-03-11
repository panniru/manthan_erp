class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :description
      t.date :created_date
      t.string :occurrence
      t.date :previous_resolution_date 
    end
  end
end
