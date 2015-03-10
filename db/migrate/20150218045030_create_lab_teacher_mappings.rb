class CreateLabTeacherMappings < ActiveRecord::Migration
  def change
    create_table :lab_teacher_mappings do |t|
      t.integer :subject_master_id
      t.integer :faculty_master_id

      t.timestamps
    end
  end
end
