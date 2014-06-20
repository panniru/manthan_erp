class InsertGradeMasterIdinSectionMasters < ActiveRecord::Migration
  def change
    change_table :section_masters do |t|
      t.string :grade_master_id
    end	
  end
end
