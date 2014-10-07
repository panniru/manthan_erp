class CreateVendorManagements < ActiveRecord::Migration
  def change
    create_table :vendor_managements do |t|
      t.string :vendor_name
      t.integer :vendor_categories_id
      t.string :vendor_phone
      t.string :vendor_email
      t.string :vendor_alternate_email
      t.text :vendor_address
      t.string :verdor_mobile

      t.timestamps
    end
  end
end
