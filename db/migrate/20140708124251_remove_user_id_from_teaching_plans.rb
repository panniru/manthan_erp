class RemoveUserIdFromTeachingPlans < ActiveRecord::Migration
  def change
  	remove_column :teaching_plans, :user_id, :integer
  	add_column :teaching_plans, :faculty_master_id, :integer
  end
end
