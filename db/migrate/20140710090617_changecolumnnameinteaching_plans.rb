class ChangecolumnnameinteachingPlans < ActiveRecord::Migration
  def change
  	remove_column :teaching_plans, :plan, :string
  	add_column :teaching_plans, :subject_master_id, :integer
  end
end
