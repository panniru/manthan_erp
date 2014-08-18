class AddDobAndStatusToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :dob, :string
    add_column :faculty_masters, :status, :string
  end
end
