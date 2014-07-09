class AddYearAndAddressToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :year, :integer
    add_column :admissions, :address, :text
  end
end
