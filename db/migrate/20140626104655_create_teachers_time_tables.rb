class CreateTeachersTimeTables < ActiveRecord::Migration
  def change
    create_table :teachers_time_tables do |t|
      t.integer :faculty_id
      t.string :academic_year
      t.integer :period_id
      t.string :mon_grade_section
      t.string :tue_grade_section
      t.string :wed_grade_section
      t.string :thu_grade_section
      t.string :fri_grade_section
      t.string :sat_grade_section
      t.string :sun_grade_section

      t.timestamps
    end
  end
end
