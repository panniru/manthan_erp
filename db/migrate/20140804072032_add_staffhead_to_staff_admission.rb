class AddStaffheadToStaffAdmission < ActiveRecord::Migration
  def change
    add_column :staff_admissions, :staffhead, :string
  end
end
