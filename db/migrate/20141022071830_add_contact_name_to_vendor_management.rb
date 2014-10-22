class AddContactNameToVendorManagement < ActiveRecord::Migration
  def change
    add_column :vendor_managements, :contact_name, :string
  end
end
