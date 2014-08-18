class AddFinalResultAndManagementResultToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :final_result, :string
    add_column :faculty_masters, :management_result, :string
  end
end
