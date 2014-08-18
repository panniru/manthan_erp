class AddStaffheadAndDescriptionToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :description, :string
    add_column :faculty_masters, :staffhead, :string
  end
end
