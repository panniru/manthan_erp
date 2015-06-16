class Admission < ActiveRecord::Base

  validates :name, presence: true
  validates :dob, presence: true
  validates :gender, presence: true
  validates :nationality, presence: true
  validates :income, presence: true
  validates :father_name, presence: true
  validates :mother_name, presence: true
  validates :father_occupation, presence: true
  validates :address_line1, presence: true
  validates :address_line2, presence: true
  validates :city, presence: true
  validates_format_of :email, :with  => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :mobile, format: { with: /\d{10}/, message: ":Enter correct format(XXXXXXXXXX)" }
  validates :language, presence: true
  validates :bus, presence: true
  validates :know_school, presence: true
  

  def get_section_master
    p "jujjjjjjjjjjjjjjjjjjjjjjjjjj"
    p grade_master_id
    get = GradeSection.where(:grade_master_id => grade_master_id)
    get_section = get.all.map do |x|
      {section_name: x.section_master.section_name, section_master_id: x.section_master_id}
    end
    return get_section
  end


  def self.get_date
    a = (Date.today.year..Date.today.year+1).map{|year| "#{year} - #{year+1}"}
    @test = a
    return @test
  end

  def self.get_year_of_study
    a = (Date.today.year-1..Date.today.year).map{|year|"#{year-1} - #{year}"}
    b = a
    return b
  end

  def self.get_no
    
    if Admission.exists?(&:form_no)
      no = Admission.maximum(:form_no)
      p "1"
      p no
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
