class Inventory < ActiveRecord::Base
  scope :request_pending,lambda{where("status = 'pending'")}
  scope :request_approved,lambda{where("status = 'Approved'")}
  scope :order_placed,lambda{where("status = 'Order placed'")}
end
