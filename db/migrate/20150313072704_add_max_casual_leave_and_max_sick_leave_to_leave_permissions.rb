class AddMaxCasualLeaveAndMaxSickLeaveToLeavePermissions < ActiveRecord::Migration
  def change
    add_column :leave_permissions, :max_casual_leave, :string
    add_column :leave_permissions, :max_sick_leave, :string
  end
end
