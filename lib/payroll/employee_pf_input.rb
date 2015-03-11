class EmployeePfInput
  attr_accessor :payslip
  
  def initialize(payslip)
    @payslip = payslip
  end

  def employee_pf_contribution
    ((self.class.pf_break_up[:epf_ee_share].to_f/100)*payslip.basic)
  end

  def employer_pf_contribution_ac_01
    (employee_pf_contribution - employee_pension_ac_10)
  end

  def employee_pension_ac_10
    eps_share = payslip.basic
    if self.class.pf_break_up[:eps_upper_limit].present?
      eps_share = (payslip.basic > self.class.pf_break_up[:eps_upper_limit] ? self.class.pf_break_up[:eps_upper_limit] : payslip.basic)
    end
    ((self.class.pf_break_up[:eps_share].to_f/100) * eps_share)
  end

  def admin_charges_ac_02
    ((self.class.pf_break_up[:admin_charges_a_c_02].to_f/100) * payslip.basic)
  end

  def edli_ac_21
    ((self.class.pf_break_up[:edli_a_c_21].to_f/100) * payslip.basic)
  end

  def edli_admin_ac_22
    ((self.class.pf_break_up[:edli_admin_a_c_22].to_f/100) * payslip.basic)
  end

  private

  def self.pf_break_up
    @@component_criterias ||= SalaryBreakUp.belongs_to_pf.map{|break_up| [break_up.component_code.to_sym, break_up.criteria] }.to_h
  end

end
