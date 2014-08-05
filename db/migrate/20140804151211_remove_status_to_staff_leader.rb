class RemoveStatusToStaffLeader < ActiveRecord::Migration
  def change
    remove_column :staff_leaders, :status, :string
  end
end
