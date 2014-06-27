class AddEnquiryNoToForm < ActiveRecord::Migration
  def change
    add_column :forms, :enquiry_no, :string
  end
end
