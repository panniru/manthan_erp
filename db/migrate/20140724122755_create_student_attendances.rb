class CreateStudentAttendances < ActiveRecord::Migration
  def change
    create_table :student_attendances do |t|
      t.integer :grade_master_id
      t.integer :section_master_id
      t.integer :student_master_id
      t.date :date
      t.string :status

      t.timestamps
    end
  end
end
