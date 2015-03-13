class Payslip < ActiveRecord::Base
  belongs_to :faculty_master
  has_one :employer_contribution
  has_one :payslip_additional_fields_label
  belongs_to :form24
  validates :basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :medical_allowance, :arrears_of_salary, :incentive_payment, :loyalty_deposit, :grade_allowance, :leave_settlement, :performance_bonus, :additional_allowance_1, :additional_allowance_2, :additional_allowance_3, :pf, :club_contribution, :professional_tax, :tds_pm, :training_cost, :salary_advance, :additional_deduction_1, :additional_deduction_2, :additional_deduction_3, :notice_period_amount, allow_blank: true, numericality: { only_integer: true }

  attr_accessor :additional_allowance_1_label, :additional_allowance_2_label, :additional_allowance_3_label
  attr_accessor :additional_deduction_1_label, :additional_deduction_2_label, :additional_deduction_3_label
  

  EARNINGS = [:basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :medical_allowance, :arrears_of_salary, :incentive_payment, :loyalty_deposit, :grade_allowance, :leave_settlement, :performance_bonus, :additional_allowance_1, :additional_allowance_2, :additional_allowance_3]

  DEDUCTIONS = [:pf, :club_contribution, :professional_tax, :tds_pm, :training_cost, :salary_advance, :notice_period_amount, :voluntary_pf_contribution, :labour_welfare_fund,:additional_deduction_1, :additional_deduction_2, :additional_deduction_3]

  scope :in_the_current_month, lambda{|date| in_the_month(date.strftime("%b")).in_the_year(date.strftime("%Y"))}
  scope :in_the_year, lambda{|year| where("to_char(generated_date, 'YYYY') = ?", year)}
  scope :in_the_month, lambda{|month| where("to_char(generated_date, 'Mon') = ?", month[0..2])}
  scope :in_the_mon, lambda{|month| where("EXTRACT(month from generated_date) = ?" , month)}
  scope :belongs_to_employee, lambda{|faculty_id| where(:faculty_master_id =>  faculty_id)}
  scope :having_status, lambda{|status| where(:status =>  status)}
  scope :approved, lambda{where(:status => "approved")}
  scope :having_loyality_allowance, lambda{ where("loyalty_allowance IS NOT NULL")}
  scope :having_annual_bonus, lambda{ where("annual_bonus IS NOT NULL")}
  scope :generated_between, lambda{|from_date, to_date| where(:generated_date => (from_date..to_date))}
  scope :manageable_by_user, lambda{|current_user| where(:faculty_master_id => FacultyMaster.managed_by(current_user))}
  scope :regulars_manageable_by_user, lambda{|current_user| where(:faculty_master_id => FacultyMaster.managed_by(current_user))}
  scope :foreigners_manageable_by_user, lambda{|current_user| where(:faculty_master_id => FacultyMaster.managed_by(current_user))}
  scope :pays_tds, lambda{ where("tds_pm > 0")}
  scope :sort_on_employee_code, lambda{ includes(:faculty_master).order("faculty_masters.code") }

  def self.payslips_on_params(params, current_user =nil)
    payslips = Payslip.all
    if params[:faculty_master_id].present? or params[:month].present? or params[:year].present? or params[:status].present?
      payslips = payslips.belongs_to_employee(params[:faculty_master_id]) if params[:faculty_master_id].present?
      payslips = payslips.in_the_month(params[:month]) if params[:month].present?
      payslips = payslips.in_the_year(params[:year]) if params[:year].present?
      payslips = payslips.having_status(params[:status]) if params[:status].present?
      payslips = payslips.manageable_by_user(current_user)
    end
    payslips.includes(:faculty_master).order("faculty_masters.code")
  end

  def change_status(status)
    self.update_attributes({:status => status})
  end
  
  def self.find_status(status)
    @emp = FacultyMaster.having_status(status).all
    return @emp
  end

  def total_earnings
    basic.to_i + hra.to_i + conveyance_allowance.to_i + city_compensatory_allowance.to_i + special_allowance.to_i + loyalty_allowance.to_i + medical_allowance.to_i + arrears_of_salary.to_i + incentive_payment.to_i + loyalty_deposit.to_i + grade_allowance.to_i + leave_settlement.to_i + performance_bonus.to_i + additional_allowance_1.to_i + additional_allowance_2.to_i + additional_allowance_3.to_i
  end

  def total_deductions
    (pf.to_i + club_contribution.to_i + professional_tax.to_i + tds_pm.to_i + training_cost.to_i + salary_advance.to_i + additional_deduction_1.to_i + additional_deduction_2.to_i + additional_deduction_3.to_i + notice_period_amount.to_i + labour_welfare_fund.to_i)
  end

  def ctc
    (faculty_master.ctc.to_f).round #/12
  end
  
  def tds_cal
    (1000/30.9*30).round
  end
  
    
  def edu
    (tds_cal*0.03).round
  end

  def net_total
    (total_earnings - total_deductions)
  end

  def pdf
    @pdf ||= PayslipPdf.new(PayslipDecorator.decorate(self))
    @pdf.payslip
    @pdf
  end
  
  def save_payslip
    ActiveRecord::Base.transaction do
      begin
        self.save!
        post_payslip_creation_actions
      # rescue Exception => e
      #   raise ActiveRecord::Rollback
      #   return false
      end
    end
    true
  end

  def post_payslip_creation_actions
    make_bonus_payment_entry
    make_additional_fields_label_entry
  end

  def mark_as_pending
    self.status = "pending"
  end
  
  def approved?
    self.status == "approved"
  end

  def generated_month
    generated_date.strftime("%b")
  end
  
  def generated_year
    generated_date.strftime("%Y")
  end

  def payslip_pdf_password
    "#{faculty_master.code}-#{faculty_master.dob.present? ? faculty_master.dob.strftime('%d-%m-%Y') : ''}"
  end

  def bonus_payment
    employer_contribution.present? ? employer_contribution.bonus_payment : @bonus_payment
  end

  def bonus_payment=(bonus)
    @bonus_payment = bonus
  end

  private

  def make_bonus_payment_entry
    bonus = Payroll::FacultyNewPayslip.new(self.faculty_master, self.generated_date).bonus_payment.round
    existing_contribution = EmployerContribution.where(:payslip_id => id).first
    if existing_contribution.present?
      existing_contribution.update_attributes({:pf => self.pf, :bonus_payment => bonus})
    else
      EmployerContribution.create!({:payslip_id => self.id, :pf => self.pf, :bonus_payment => bonus, :generated_date => self.generated_date, :faculty_master_id => self.faculty_master.id})
    end
  end
  
  def make_additional_fields_label_entry
    payslip_label = PayslipAdditionalFieldsLabel.where(:payslip_id => id).first || PayslipAdditionalFieldsLabel.new
    payslip_label.payslip = self
    (1..3).each do |index|
      payslip_label.send("additional_allowance_#{index}=", self.send("additional_allowance_#{index}_label"))
      payslip_label.send("additional_deduction_#{index}=", self.send("additional_deduction_#{index}_label"))
    end
    payslip_label.save!
  end
end


