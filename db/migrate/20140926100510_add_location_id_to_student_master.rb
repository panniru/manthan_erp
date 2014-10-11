class AddLocationIdToStudentMaster < ActiveRecord::Migration
  def change
    add_column :student_masters, :location_id, :integer
  end
end
