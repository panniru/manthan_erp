class AddBusFacilityToStudentMasters < ActiveRecord::Migration
  def change
    add_column :student_masters, :bus_facility, :boolean
  end
end
