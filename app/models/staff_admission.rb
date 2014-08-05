class StaffAdmission < ActiveRecord::Base
  
  scope :closed_forms,lambda{where("status = 'Form_Closed'")}
  scope :sports,lambda{where("staffhead = ' NAVYA-Transport '")}
  scope :enquiry_forms,lambda{where("status = 'Application_Created'")}
  scope :document_verified,lambda{where("status = 'Document_Verified'")}
  scope :assessment_planned,lambda{where("status = 'Assessment_Planned'")}
  scope :assessment_completed,lambda{where("status = 'Assessment_Completed'")}
  scope :management_review,lambda{where("status = 'Management_Reviewed'")}
  scope :selected_staffs,lambda{where("status = 'Selected'")}
  has_one :recruitment, :dependent => :destroy
  serialize :language, Array
  scope :search, lambda {|id| where(:id => id)}
  def self.search(search)
    if search 
      find(:all, :conditions => ['status LIKE ? ', "%#{search}%"])
    else
      find(:all)
    end
  end
 
end
