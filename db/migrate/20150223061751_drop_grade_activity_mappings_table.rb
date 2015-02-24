class DropGradeActivityMappingsTable < ActiveRecord::Migration
  def change
  	drop_table :grade_activity_mappings
  end
end
