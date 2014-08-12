class Staffrecruit < ActiveRecord::Base
  belongs_to :staff_admission, :foreign_key => 'staff_admission_id'
  
  scope :search, lambda {|id| where(:id => id)}
  def self.search(search)
    if search 
      find(:all, :conditions => ['status LIKE ? ', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  scope :application_forms, lambda{where("status = 'Application_Created' or status = 'Document_Verified' or status = 'Assessment_Planned'or status = 'Assessment_Completed' or status = 'Management_Reviewed' or status = 'Selected'")}
  scope :closed_forms,lambda{where("status = 'Form_Closed' or final_result = 'Rejected'")}
  scope :document_verified,lambda{where("status = 'Document_Verified'")}
  scope :assessment_completed,lambda{where("status = 'Assessment_Completed'")}
  scope :management_review,lambda{where("status = 'Management_Reviewed'")}
  scope :selected_staffs,lambda{where("final_result = 'Selected'")}
  mount_uploader :educational_certificates, EducationalCertificatesUploader# Teprevious_employment_proof, 
  mount_uploader :previous_employment_proof,PreviousEmploymentProofUploader
  mount_uploader :salary_slips_for_previous_months, SalarySlipsForPreviousMonthsUploader
  


end
