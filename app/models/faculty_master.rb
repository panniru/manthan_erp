class FacultyMaster < ActiveRecord::Base

  scope :on_designation, lambda { |designation| where("designation = ? ", designation)}
  belongs_to :user
  belongs_to :attendance
  has_many :students, :class_name => "StudentMaster"
  mount_uploader :educational_certificates, EducationalCertificatesUploader
  mount_uploader :previous_employment_proof,PreviousEmploymentProofUploader
  mount_uploader :salary_slips_for_previous_months, SalarySlipsForPreviousMonthsUploader
  scope :show_all_faculties, lambda{|designation| where(:designation => designation).select(:id,:faculty_name, :designation)}
  
  def self.get_faculty_names_by_role(current_user)
    if current_user.admin?
      faulty_names = FacultyMaster.all.map do |faculty|
        {faculty_master_id: faculty.id, faculty_name: faculty.faculty_name}
      end
   
    elsif current_user.teacher?
      faulty_names = FacultyMaster.where('id = '+"#{current_user.faculty_master.id}").all.map do |faculty|
        {faculty_master_id: faculty.id, faculty_name: faculty.faculty_name}
      end
    end
  end
  

  

     
end
