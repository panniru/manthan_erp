class CreateStudentHrs < ActiveRecord::Migration
  def change
    create_table :student_hrs do |t|
      t.string :name
      t.date :dob
      t.date :joining_date
      t.string :grade
      t.string :section
      t.string :academic_year
      t.integer :parent_id

      t.timestamps
    end
  end
end
