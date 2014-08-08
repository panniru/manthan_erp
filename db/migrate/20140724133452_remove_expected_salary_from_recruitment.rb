class RemoveExpectedSalaryFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :expected_salary, :string
  end
end
