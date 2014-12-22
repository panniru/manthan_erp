class AddReturnTypeOfDayToLeavePermissions < ActiveRecord::Migration
  def change
    add_column :leave_permissions, :return_type_of_day, :string
  end
end
