class AddTypeOfDayToLeavePermissions < ActiveRecord::Migration
  def change
    add_column :leave_permissions, :type_of_day, :string
  end
end
