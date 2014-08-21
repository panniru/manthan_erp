class AddDeptToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :dept, :string
  end
end
