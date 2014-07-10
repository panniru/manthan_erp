class RemoveStaffidAndChangeGradeAndSectionMasterIdDatatypesInTimeTables < ActiveRecord::Migration
  def change  
   remove_column :time_tables, :staffid, :string
   change_column :time_tables, :grade_master_id, 'integer USING CAST(grade_master_id AS integer)'
   change_column :time_tables, :section_master_id, 'integer USING CAST(section_master_id AS integer)'
   change_column :time_tables, :mon_sub, 'integer USING CAST(mon_sub AS integer)'
   change_column :time_tables, :tue_sub, 'integer USING CAST(tue_sub AS integer)'
   change_column :time_tables, :wed_sub, 'integer USING CAST(wed_sub AS integer)'
   change_column :time_tables, :thu_sub, 'integer USING CAST(thu_sub AS integer)'
   change_column :time_tables, :fri_sub, 'integer USING CAST(fri_sub AS integer)'
   change_column :time_tables, :sat_sub, 'integer USING CAST(sat_sub AS integer)' 
   change_column :time_tables, :sun_sub, 'integer USING CAST(sun_sub AS integer)'
  end   
end
