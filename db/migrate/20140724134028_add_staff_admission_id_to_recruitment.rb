class AddStaffAdmissionIdToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :staff_admission_id, :integer
  end
end
