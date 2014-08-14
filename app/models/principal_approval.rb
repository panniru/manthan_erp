class PrincipalApproval < ActiveRecord::Base
  has_many :request_new_book
  # scope :request_accept,lambda{where("status = 'Approval_Sent'")}
end
