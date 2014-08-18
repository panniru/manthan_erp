class AddEducationQualificationToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :education_qualification, :string
  end
end
