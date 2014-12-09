class CreateFacultyAttendances < ActiveRecord::Migration
  def change
    create_table :faculty_attendances do |t|
      t.integer :faculty_master_id
      t.string :designation
      t.string :forenoon
      t.string :afternoon
      t.string :attendance_date
      t.string :name

      t.timestamps
    end
  end
end
