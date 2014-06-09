class ChangeGradeSectionOfStudentHr < ActiveRecord::Migration
  def change
    remove_column :student_hrs, :grade, :string
    remove_column :student_hrs, :section, :string
    add_column :student_hrs, :grade, :integer
    add_column :student_hrs, :section, :integer
  end
end
