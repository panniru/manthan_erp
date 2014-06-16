class AddSubjectMasterIdColumn < ActiveRecord::Migration
  def change
  	change_table :time_tables do |t|
  	t.remove :grademaster_id
  	t.remove :sectionmaster_id
  	
    t.string :grade_master_id
    t.string :section_master_id
    end	
  end
end
