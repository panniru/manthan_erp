class ChangeLossOfPayStringInLeavePermission < ActiveRecord::Migration
  def change
    remove_column :leave_permissions, :loss_of_pay_count, :string
    add_column :leave_permissions, :loss_of_pay_count, :float
   
  end
end
