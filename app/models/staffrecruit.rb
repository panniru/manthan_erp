class Staffrecruit < ActiveRecord::Base

  def self.getno
    if Staffrecruit.exists?(&:form_no)
      no = Staffrecruit.all.map(&:form_no).last
      nos = no.to_i
      nos +=1
      return nos
      else
      form123 = DefaultMaster.get_form_no.map(&:default_value).first
      form1234 = form123.to_i
      return form1234
    end
  end


  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :mobile_no, format: { with: /\d{10}/, message: ":Enter correct format(XXXXXXXXXX)" }
  validates :faculty_name, presence: true
  validates :nationality, presence: true
  validates :dob, presence: true
  validates :address, presence: true
  validates :gender, presence: true
  validates :education_qualification, presence: true
  belongs_to :staffadmin,:foreign_key => 'staffadmin_id'
  belongs_to :staff_admission, :foreign_key => 'staff_admission_id'
  belongs_to :faculty_master
  scope :search, lambda {|id| where(:id => id)}
  def self.search(search)
    if search 
      find(:all, :conditions => ['status LIKE ? ', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  scope :application_forms, lambda{where("status = 'Application Created' or status = 'Document Verified' or status = 'Assessment Planned'or status = 'Assessment Completed' or status = 'Management Reviewed' or status = 'Selected'")}
  scope :closed_forms,lambda{where("status = 'Form Closed' or final_result = 'Rejected'")}
  scope :application_created,lambda{where("status = 'Application Created'")}
  scope :document_verified,lambda{where("status = 'Document Verified'")}
  scope :assessment_planned,lambda{where("status = 'Assessment Planned'")}  
  scope :assessment_completed,lambda{where("status = 'Assessment Completed'")}
  scope :management_review,lambda{where("status = 'Management Reviewed'")}
  scope :selected_staffs,lambda{where("final_result = 'Selected' and status != 'Form Closed'")}
  mount_uploader :educational_certificates, EducationalCertificatesUploader# Teprevious_employment_proof, 
  mount_uploader :previous_employment_proof,PreviousEmploymentProofUploader
  mount_uploader :salary_slips_for_previous_months, SalarySlipsForPreviousMonthsUploader
  


end
