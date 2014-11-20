class VendorManagement < ActiveRecord::Base
  belongs_to :vendor_category
  # validates :vendor_name , :presence => true
  # validates_format_of :vendor_email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  # validates :vendor_address, :presence => true
  # validates :verdor_mobile, :presence => true
  # validates :contact_name, :presence => true
  
end
