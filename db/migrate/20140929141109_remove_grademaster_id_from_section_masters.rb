class RemoveGrademasterIdFromSectionMasters < ActiveRecord::Migration
  def change
  	remove_column :section_masters, :grade_master_id, :integer
  end
end
