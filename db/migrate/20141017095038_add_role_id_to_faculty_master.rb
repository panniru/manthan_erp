class AddRoleIdToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :role_id, :integer
  end
end
