class AddStaffLeaderIdToStaffAdmission < ActiveRecord::Migration
  def change
    add_column :staff_admissions, :staff_leader_id, :integer
  end
end
