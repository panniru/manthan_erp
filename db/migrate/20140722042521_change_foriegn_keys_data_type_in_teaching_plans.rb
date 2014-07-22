class ChangeForiegnKeysDataTypeInTeachingPlans < ActiveRecord::Migration
  def change
    remove_column :teaching_plans, :grade_master_id, :string
    remove_column :teaching_plans, :section_master_id, :string
    add_column :teaching_plans, :grade_master_id, :integer
    add_column :teaching_plans, :section_master_id, :integer
  end
end
