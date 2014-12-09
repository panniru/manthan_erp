class CreateLeavePermissions < ActiveRecord::Migration
  def change
    create_table :leave_permissions do |t|
      t.integer :faculty_master_id
      t.string :type_of_leave
      t.string :from_date
      t.string :to_date
      t.string :reason
      t.string :status
      t.float :bal_leave
      t.float :casual_leave_count
      t.float :sick_leave_count
      t.integer :faculty_attendance_id

      t.timestamps
    end
  end
end
