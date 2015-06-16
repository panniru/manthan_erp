class AddSchoolHouseToStudentMaster < ActiveRecord::Migration
  def change
    add_column :student_masters, :school_house, :string
  end
end
