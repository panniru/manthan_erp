class AddClosestatusToAdmissions < ActiveRecord::Migration
  def change
    add_column :admissions, :closestatus, :string
  end
end
