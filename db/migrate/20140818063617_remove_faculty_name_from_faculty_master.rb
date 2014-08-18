class RemoveFacultyNameFromFacultyMaster < ActiveRecord::Migration
  def change
    remove_column :faculty_masters, :faculty_name, :string
  end
end
