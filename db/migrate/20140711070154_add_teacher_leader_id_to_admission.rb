class AddTeacherLeaderIdToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :teacher_leader_id, :integer
  end
end
