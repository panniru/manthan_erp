class EnquiryFormObject
  include Virtus.model
  attribute :form_no, String
  attribute :name, String
  attribute :dob, String
  attribute :gender, String
  attribute :email, String
  attribute :mobile_no, String
  attribute :experience, String
  attribute :klass, String
  attribute :subject, String
  attribute :educational_qualification, String
  attribute :expected_salary, String
  attribute :nationality, String
  attribute :post, String
  attribute :status, String
  attribute :language, String
  
  def update(params={})
    get_recruitment.update(params)
  end
  
  def load_recruitment
    staff_admission_id.present?  ? StaffAdmission.find(staff_admission_id) : StaffAdmission.new
  end
  
  def get_recruitment
    @staff_admission ||= load_recruitment
  end		
  
  def save
    if valid?
      persist!
      true
    else
      false
    end
  end
  private
  def persist!
    @staff_admission = StaffAdmission.create!(form_no: @staff_admission.form_no,name: @staff_admission.name, email: @staff_admission.email, dob: @staff_admission.dob, gender: @staff_admission.gender, mobile_no: @staff_admission.mobile_no, experience: @staff_admission.experience, klass: @staff_admission.klass, subject: @staff_admission.subject, education_qualification: @staff_admission.education_qualification, expected_salary: @staff_admission.expected_salary, nationality: @staff_admission.nationality, language: @staff_admission.language)
  end
  

end

