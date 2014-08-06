class AddClosestatusToStaffAdmission < ActiveRecord::Migration
  def change
    add_column :staff_admissions, :closestatus, :string
  end
end
