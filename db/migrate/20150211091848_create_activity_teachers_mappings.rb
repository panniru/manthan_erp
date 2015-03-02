class CreateActivityTeachersMappings < ActiveRecord::Migration
  def change
    create_table :activity_teachers_mappings do |t|
      t.integer :activity_master_id
      t.integer :faculty_master_id

      t.timestamps
    end
  end
end
