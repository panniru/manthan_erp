class Inventory < ActiveRecord::Base
  scope :request_pending,lambda{where("status = 'Pending'")}
  scope :request_approved,lambda{where("status = 'Approved'")}
  scope :order_placed,lambda{where("status = 'Order placed'")}
end
