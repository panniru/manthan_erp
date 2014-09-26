class AddLocationMasterIdToStudentMaster < ActiveRecord::Migration
  def change
    add_column :student_masters, :location_master_id, :integer
  end
end
