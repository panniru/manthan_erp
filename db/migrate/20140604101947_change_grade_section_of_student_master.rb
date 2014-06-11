class ChangeGradeSectionOfStudentMaster < ActiveRecord::Migration
  def change
    remove_column :student_masters, :grade, :string
    remove_column :student_masters, :section, :string
    add_column :student_masters, :grade, :integer
    add_column :student_masters, :section, :integer
  end
end
