class AddEnquiryNoToDocumentuploaders < ActiveRecord::Migration
  def change
    add_column :documentuploaders, :enquiry_no, :string
  end
end
