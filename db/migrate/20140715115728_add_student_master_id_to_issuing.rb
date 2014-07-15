class AddStudentMasterIdToIssuing < ActiveRecord::Migration
  def change
    add_column :issuings, :student_master_id, :integer
  end
end
