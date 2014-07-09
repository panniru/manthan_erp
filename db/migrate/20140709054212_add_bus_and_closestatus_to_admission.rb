class AddBusAndClosestatusToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :bus, :string
    add_column :admissions, :closestatus, :string
  end
end
