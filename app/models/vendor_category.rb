class VendorCategory < ActiveRecord::Base
  belongs_to :vendor_management
  #validates_uniqueness_of :vendor_category , :presence => true
end
