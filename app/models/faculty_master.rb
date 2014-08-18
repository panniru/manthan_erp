class FacultyMaster < ActiveRecord::Base
  belongs_to :user
  mount_uploader :educational_certificates, EducationalCertificatesUploader
  mount_uploader :previous_employment_proof,PreviousEmploymentProofUploader
  mount_uploader :salary_slips_for_previous_months, SalarySlipsForPreviousMonthsUploader
  
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
