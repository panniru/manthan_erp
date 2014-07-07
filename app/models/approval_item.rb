class ApprovalItem < ActiveRecord::Base
  
  scope :fee_structure_type, lambda{ where(:item_type => 'fee_structure')}
  
  def approved_user
    User.find(approved_by).user_id if approved_by.present?
  end

  def defined_user
    User.find(defined_by).user_id if defined_by.present?
  end

  def approve(current_user)
    self.status = "approved"
    self.approved_by = current_user.id
    self.save!
  end
  
  def reject
    update!(:status => "rejected")
  end

  def self.fee_can_be_edit?
    approval_item = ApprovalItem.fee_structure_type.last
    if approval_item.present?
      approval_item.status != 'pending' and approval_item.status != 'approved'
    else
      true
    end
  end
  
end
