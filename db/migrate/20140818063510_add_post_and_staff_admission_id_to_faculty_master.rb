class AddPostAndStaffAdmissionIdToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :post, :string
    add_column :faculty_masters, :staff_admission_id, :integer
  end
end
