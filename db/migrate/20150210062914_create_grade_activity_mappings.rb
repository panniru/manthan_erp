class CreateGradeActivityMappings < ActiveRecord::Migration
  def change
    create_table :grade_activity_mappings do |t|
      t.integer :activity_master_id
      t.integer :grade_master_id

      t.timestamps
    end
  end
end
