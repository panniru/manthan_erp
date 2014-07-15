class AddTeacherLeaderIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :teacher_leader_id, :integer
  end
end
