class AddStudentAttendanceToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :student_attendance, :string
  end
end
