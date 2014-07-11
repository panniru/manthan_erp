class AddGradeMasterIdToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :grade_master_id, :integer
  end
end
