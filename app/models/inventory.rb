class Inventory < ActiveRecord::Base
  scope :request_pending,lambda{where("status = 'pending'")}
end
