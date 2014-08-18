class AddEmailAndMobileNoAndAddressToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :email, :string
    add_column :faculty_masters, :mobile_no, :string
    add_column :faculty_masters, :address, :string
  end
end
