class AddFieldsToFacultyAttendances < ActiveRecord::Migration

  
  def change
    add_column  :faculty_attendances, :type_of_leave, :string
    add_column  :faculty_attendances, :pending_casual_leave, :float
    add_column  :faculty_attendances, :pending_sick_leave, :float
    add_column  :faculty_attendances, :max_casual_leave, :float
    add_column  :faculty_attendances, :max_sick_leave, :float
  end
end
