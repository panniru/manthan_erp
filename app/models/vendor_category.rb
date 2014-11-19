class VendorCategory < ActiveRecord::Base
  has_many :vendor_managements

  
  #validates_uniqueness_of :vendor_category , :presence => true
end
