WillPaginate.per_page = 30
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

  before_save :set_special_allowance
  def set_special_allowance
    if self.changed_attributes.include? "ctc" or self.changed_attributes.include? "basic"
      self.special_allowance = Payroll::SalaryBreakUpCreator.new(ctc, basic, probation_date, Date.today, designation_master.try(:name)).special_allowance.round
    end 
  end

  def last_annual_bonus_paid_on
    payslip = self.payslips.select(:generated_date).having_annual_bonus.order("generated_date DESC").first
    if payslip.present?
      return payslip.generated_date
    else
      nil
    end
  end

  def eligible_for_payslip?(date)
    (resignation_date.present? and resignation_date < date.at_beginning_of_month) ? false : true
  end

  def leaves_taken_in_the_month(date)
    faculty_leaves.in_the_month(date.strftime("%b")).in_the_year(date.strftime("%Y")).first
  end

  def eligible_for_loyality_allowance?(date)
    date_before_3_years = Date.new(date.year-3, date.month, date.day)
    (probation_date.present? and probation_date <= date_before_3_years)
  end

  def eligible_for_leave_settlement?(date)
    date.month == rule_engine(:leave_settlement_month)
  end

  def eligible_for_annual_bonus_payment?(date)
    date.month == rule_engine(:bonus_payment_month)
  end

  def eligible_for_labour_welfare_fund?(date)
    date.month == rule_engine(:labour_welfare_fund_month)
  end

  def rule_engine(code)
    SalaryBreakUp.find_by_component_code(code).try(:criteria)
  end
  
  
  def readable_by_user? user
    if user.admin? or user.accountant?
      true
    else
      self.designation_master.managed_by == user.role_id
    end
  end
  
  def editable_by_user? user
    readable_by_user? user
  end

  def leaves_taken_in_the_month(date)
    faculty_leaves.in_the_month(date.strftime("%b")).in_the_year(date.strftime("%Y")).first
  end


  has_many :salary_taxes
  has_many :form24s
  has_many :payslips
  has_many :employee_advance_payments
  has_many :faculty_leaves , :class_name => "FacultyLeave" 
  attr_accessor :department_name
  attr_accessor :designation_name
  belongs_to :department_master
  belongs_to :designation_master
  scope :having_status , lambda{}
  scope :having_designation, lambda{|design_id| where(:designation_master_id => design_id)}
  scope :has_no_pay_slips_in_the_month, lambda{|date| where("id not in (?)", Payslip.select(:faculty_master_id).in_the_current_month(date))}
  scope :not_resigned_on_or_before_month_begin, lambda{|date| where("resignation_date IS NULL OR resignation_date >= ?", date.at_beginning_of_month)}
  scope :managed_by, (lambda do |user| 
                        if user.admin? or accountant?
                          all
                        else
                          where(:designation_master_id => DesignationMaster.select(:id).managed_by(user))
                        end
                      end)
  def save_employee
    ActiveRecord::Base.transaction do
      begin
        self.department_master = department_from_params
        self.designation_master = designation_from_params
        if self.save
          return true
        else
          raise ActiveRecord::Rollback
          return false
        end
      end
    end
  end
  def department_from_params
    dept = nil
    if department_name.present? && department_master_id.blank?
      dept = DepartmentMaster.where(:name => department_name).first
      if not dept.present?
        dept = DepartmentMaster.create({:name => department_name})
      end
    elsif department_master_id.present?
      dept = DepartmentMaster.find(department_master_id)
    end
    dept
  end

  def designation_from_params
    designation = nil
    if designation_name.present? && designation_master_id.blank?
      designation = DesignationMaster.where(:name => designation_name).first
      if not designation.present?
        designation = DesignationMaster.create({:name => designation_name})
      end
    elsif designation_master_id.present?
      designation = DesignationMaster.find(designation_master_id)
    end
    designation
  end

  
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


  private
  
  def set_special_allowance
    if self.changed_attributes.include? "ctc" or self.changed_attributes.include? "basic"
      self.special_allowance = Payroll::SalaryBreakUpCreator.new(ctc, basic, probation_date, Date.today, designation_master.try(:name)).special_allowance.round
    end 
  end
  
  def date_of_birth_cannot_be_in_past
    errors.add(:dob, "can't be in the future") if date_of_birth.present? and date_of_birth > Date.today
  end

  def date_of_joining_cannot_be_in_past
    errors.add(:date_of_joining, "can't be in the future") if date_of_joining.present? and date_of_joining > Date.today
  end

  def date_of_resignation_cannot_be_less_than_joining
    errors.add(:resignation_date, "can't be less than joining date") if resignation_date.present? and date_of_joining.present? and resignation_date < date_of_joining
  end

  def date_of_probation_cannot_be_less_than_joining 
    errors.add(:probation_date, "can't be less than joining date") if probation_date.present? and date_of_joining.present? and probation_date < date_of_joining
  end
  
     

end

