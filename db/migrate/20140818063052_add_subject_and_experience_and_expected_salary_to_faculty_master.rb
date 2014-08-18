class AddSubjectAndExperienceAndExpectedSalaryToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :subject, :string
    add_column :faculty_masters, :experience, :string
    add_column :faculty_masters, :expected_salary, :string
  end
end
