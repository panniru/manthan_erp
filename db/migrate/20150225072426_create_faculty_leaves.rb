class CreateFacultyLeaves < ActiveRecord::Migration
  def change
    create_table :faculty_leaves do |t|
      t.integer :faculty_master_id
      t.string :month
      t.integer :lop
      t.float :days_worked
      t.integer :working_days
      t.integer :sl
      t.integer :pl
      t.integer :cl
      t.string :code
      t.date :entered_date
      t.integer :year

      t.timestamps
    end
  end
end
