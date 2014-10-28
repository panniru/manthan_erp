class Admission < ActiveRecord::Base


  def self.get_no
    
    if Admission.exists?(&:form_no)
      no = Admission.all.map(&:form_no).last
      nos = no.to_i
      nos +=1
      p nos
      return nos
    else
      form123 = DefaultMaster.get_form_no.map(&:default_value).first
      form1234 = form123.to_i
      p "1111111111111"
      p form1234
      return form1234
    end
  end

  has_one :default_master
  belongs_to :parent_master
  belongs_to :student_master
  belongs_to :grade_master
  belongs_to :teacher_leader,:foreign_key => 'teacher_leader_id'
  scope :enquiry_forms_or_application_forms, lambda{where("status = 'Enquiry Created' or status = 'Application Created' or status = 'Assessment Planned' or status = 'Assessment Completed' or status = 'Management Reviewed' or status = 'Selected'")}
  scope :closed_forms,lambda{where("status = 'Form Closed'")}
  scope :enquiry_forms,lambda{where("status = 'Enquiry Created'")}
  scope :application_forms,lambda{where("status = 'Application Created'")}
  scope :assessment_planned,lambda{where("status = 'Assessment Planned'")}
  scope :assessment_completed,lambda{where("status = 'Assessment Completed'")}
  scope :management_review,lambda{where("status = 'Management Reviewed'")}
  scope :selected_students,lambda{where("finalresult = 'Selected' and status != 'Form Closed'" )}
  scope :search, lambda {|id| where(:id => id)}
  def self.search(search)
    if search 
      find(:all, :conditions => ['status LIKE ? ', "%#{search}%"])
    else
      find(:all)
    end
  end
  

end
