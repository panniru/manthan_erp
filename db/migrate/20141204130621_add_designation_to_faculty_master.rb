class AddDesignationToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :designation, :string
  end
end
