class RemoveTypeOfDayAndReturnTypeOfDayFromLeavePermissions < ActiveRecord::Migration
  def change
    remove_column :leave_permissions, :return_type_of_day, :string
    remove_column :leave_permissions, :type_of_day, :string

  end
end
