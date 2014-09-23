class RemoveAttendanceDateFromAttendances < ActiveRecord::Migration
  def change
    remove_column :attendances, :attendance_date, :date
    add_column :attendances, :attendance_date, :date
  end
end
