class AddStaffLeaderToTeacherLeader < ActiveRecord::Migration
  def change
    add_column :teacher_leaders, :staff_leader, :string
  end
end
