class AddVendorCategoryIdToVendorManagements < ActiveRecord::Migration
  def change
    add_column :vendor_managements, :vendor_category_id, :integer
  end
end
