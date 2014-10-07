class CreateVendorCategories < ActiveRecord::Migration
  def change
    create_table :vendor_categories do |t|
      t.string :vendor_category

      t.timestamps
    end
  end
end
