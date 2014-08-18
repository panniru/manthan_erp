class AddClosestatusAndCommentsToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :closestatus, :string
    add_column :faculty_masters, :comments, :string
  end
end
