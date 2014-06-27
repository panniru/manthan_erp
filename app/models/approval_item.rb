class ApprovalItem < ActiveRecord::Base

  def approve(current_user)
    self.status = "approved"
    self.approved_by = current_user.id
    self.save!
  end
  
end
