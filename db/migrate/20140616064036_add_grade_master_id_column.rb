class AddGradeMasterIdColumn < ActiveRecord::Migration
  def change
  	change_table :time_tables do |t|
  	t.remove :gradeid
  	t.remove :section
  	t.remove :periodid
  	
    t.string :grademaster_id
    t.string :sectionmaster_id
    end	
  end
end
