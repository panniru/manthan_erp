class AddFacultyToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :faculty, :string
  end
end
