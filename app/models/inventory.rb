class Inventory < ActiveRecord::Base
  def self.get_request_by_role(current_user) 
    if current_user.admin?
      @inventories = Inventory.where('status = '+"'Approved'")           
    elsif current_user.canteenmanager?
      @inventories = Inventory.where('status = '+"'Pending'")         
    elsif current_user.principal?
      @inventories = Inventory.where('status = '+"'Pending'"+" OR "+'status = '+"'Approved'"+" OR "+'status = '+"'Rejected'")           
    end		
  end
  # scope :request_pending,lambda{where("status = 'Pending'")}
  # scope :request_approved,lambda{where("status = 'Approved'")}
  # scope :order_placed,lambda{where("status = 'Order placed'")}
end
