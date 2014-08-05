class AddPostToStaffAdmission < ActiveRecord::Migration
  def change
    add_column :staff_admissions, :post, :string
  end
end
