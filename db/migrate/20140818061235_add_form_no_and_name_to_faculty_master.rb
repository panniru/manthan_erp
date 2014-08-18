class AddFormNoAndNameToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :form_no, :string
    add_column :faculty_masters, :name, :string
  end
end
