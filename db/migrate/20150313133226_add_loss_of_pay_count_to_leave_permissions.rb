class AddLossOfPayCountToLeavePermissions < ActiveRecord::Migration
  def change
    add_column :leave_permissions, :loss_of_pay_count, :string
  end
end
