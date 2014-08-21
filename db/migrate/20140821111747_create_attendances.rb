class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :grade_master_id
      t.integer :section_master_id
      t.integer :faculty_master_id
      t.integer :student_master_id
      t.string :attendance

      t.timestamps
    end
  end
end
