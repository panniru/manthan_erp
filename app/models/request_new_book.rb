class RequestNewBook < ActiveRecord::Base
  belongs_to :principal_approval
  scope :request_accept,lambda{where("status = 'Approval_Sent'")}
  scope :request_approval,lambda{where("status = 'Send_Approval'")}
  scope :book_accept,lambda{where("status = 'Accepted'")}
  scope :book_reject,lambda{where("status = 'Rejected'")}
end

