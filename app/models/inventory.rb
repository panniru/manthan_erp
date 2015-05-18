class Inventory < ActiveRecord::Base
  def self.get_request_by_role(current_user) 
    if current_user.admin?
      @inventories = Inventory.where('status = '+"'Approved'")           
    elsif current_user.canteenmanager? 
      @inventories = Inventory.where('status = '+"'Pending'"+" OR "+'status = '+"'Ordered'"+" OR "+'status = '+"'Rejected'"+" OR "+'status = '+"'Delivered'" )         
    elsif current_user.principal?
      @inventories = Inventory.where('status = '+"'Pending'"+" OR "+'status = '+"'Approved'"+" OR "+'status = '+"'Rejected'")           
    end		
  end
  
  def pending
    if status == "Pending"
      return "Principal"
    elsif status == "Approved"
      return "Admin"
    elsif status == "Ordered"
      return "Vendor"
    end
    
  end

  validates_uniqueness_of :name, presence: true
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :inventory_type, presence: true
end
