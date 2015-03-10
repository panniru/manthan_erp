class FacultyMaster < ActiveRecord::Base

  scope :on_designation, lambda { |designation| where("designation = ? ", designation)}
  belongs_to :user
  belongs_to :attendance
  belongs_to :leave_permission
  has_many :students, :class_name => "StudentMaster"
  mount_uploader :educational_certificates, EducationalCertificatesUploader
  mount_uploader :previous_employment_proof,PreviousEmploymentProofUploader
  mount_uploader :salary_slips_for_previous_months, SalarySlipsForPreviousMonthsUploader
  scope :show_all_faculties, lambda{|designation| where(:designation => designation).select(:id,:faculty_name, :designation)}
  # before_save :handle_faculty_id

  # def handle_faculty_id
 #   self.faculty_id = self.faculty_id.select(&:present?).join(';') 
  #   # .select(&:present?) is necessary to avoid empty objects to be stored
  # end
  
  # def faculty
  #   self.class.find(self.faculty_id.split(';'))
  # end

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

  
  def get_casual_leave(designation)
    a = designation
    form = SetupMaster.select('casual_leave').where(:designation => a).map {|designation| designation.casual_leave}
    return form[0]
  end

  def get_sick_leave(designation)
    a = designation
    form = SetupMaster.select('sick_leave').where(:designation => a).map {|designation| designation.sick_leave}
    return form[0]
  end

  def get_pending_casual_leave(designation)
    count_no = FacultyAttendance.where(:designation => designation,:type_of_leave => 'casual leave').select(%q{faculty_master_id, name, max_casual_leave - sum(case when forenoon = 'A' and afternoon = '' then 0.5 else 0 end + case when forenoon = '' and afternoon = 'A' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'A' then 1 else 0 end + case when forenoon = 'P' and afternoon = 'A' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'P' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = '' then 0.5 else 0 end + case when forenoon = '' and afternoon = 'L' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = 'L' then 1 else 0 end +  case when forenoon = 'P'  and afternoon = 'L' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'L' then 1 else 0 end + case when forenoon = 'L' and afternoon = 'P' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = 'A' then 1 else 0 end ) as pending_casual_leave }).group('faculty_master_id','name','max_casual_leave').map {|d| d.pending_casual_leave}
    return count_no
  end

  def get_pending_sick_leave(designation)
    count_no = FacultyAttendance.where(:designation => designation,:type_of_leave => 'sick leave').select(%q{faculty_master_id, name, max_sick_leave - sum(case when forenoon = 'A' and afternoon = '' then 0.5 else 0 end + case when forenoon = '' and afternoon = 'A' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'A' then 1 else 0 end + case when forenoon = 'P' and afternoon = 'A' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'P' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = '' then 0.5 else 0 end + case when forenoon = '' and afternoon = 'L' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = 'L' then 1 else 0 end +  case when forenoon = 'P'  and afternoon = 'L' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'L' then 1 else 0 end + case when forenoon = 'L' and afternoon = 'P' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = 'A' then 1 else 0 end ) as pending_sick_leave }).group('faculty_master_id','name','max_sick_leave').map {|d| d.pending_sick_leave}
    return count_no
  end

end

