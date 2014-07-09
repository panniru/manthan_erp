class AddFacultyIdToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :faculty_id, :string
  end
end
