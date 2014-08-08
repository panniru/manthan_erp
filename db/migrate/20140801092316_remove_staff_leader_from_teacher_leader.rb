class RemoveStaffLeaderFromTeacherLeader < ActiveRecord::Migration
  def change
    remove_column :teacher_leaders, :staff_leader, :string
  end
end
