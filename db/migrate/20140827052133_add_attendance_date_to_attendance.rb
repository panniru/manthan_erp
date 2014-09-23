class AddAttendanceDateToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :attendance_date, :date
  end
end
