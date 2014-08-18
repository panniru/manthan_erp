class AddStartTimeAndEndTimeToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :end_time, :string
    add_column :faculty_masters, :start_time, :string
  end
end
