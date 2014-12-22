class ChangeDataFormatInLeavePermission < ActiveRecord::Migration
  def change
    add_column :leave_permissions, :from_day, :float
    add_column :leave_permissions, :to_day, :float
  end

end
