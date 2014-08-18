class AddTitleAndSalarySlipsForPreviousMonthsToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :title, :string
    add_column :faculty_masters, :salary_slips_for_previous_months, :string
  end
end
