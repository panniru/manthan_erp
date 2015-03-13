class PfInput
  attr_accessor :payslips
  
  def initialize(payslips)
    @payslips = payslips
  end

  def employee_share_ac_01
    employee_pf_inputs[:employee_share_ac_01].round
  end

  def employer_share_ac_01
    employee_pf_inputs[:employer_share_ac_01].round
  end

  def employer_share_ac_10
    employee_pf_inputs[:employer_share_ac_10].round
  end

  def administration_charges_ac_2
    employee_pf_inputs[:administration_charges_ac_2].round
  end

  def edli_charges_ac_21
    employee_pf_inputs[:edli_charges_ac_21].round
  end

  def edli_admin_charges_ac_22
    employee_pf_inputs[:edli_admin_charges_ac_22].round
  end

  def total
    employee_share_ac_01 + employer_share_ac_01 + employer_share_ac_10 + administration_charges_ac_2 + edli_charges_ac_21 + edli_admin_charges_ac_22
  end

  def employee_pf_inputs
    @employee_pf_inputs ||= generate_pf_aggregations
  end

  private

  def generate_pf_aggregations
    totals = {
      employee_share_ac_01: 0,
      employer_share_ac_01: 0,
      employer_share_ac_10: 0,
      administration_charges_ac_2: 0,
      edli_charges_ac_21: 0,
      edli_admin_charges_ac_22: 0
    }
    payslips.each do |payslip| 
      epf = EmployeePfInput.new(payslip)
      totals[:employee_share_ac_01] += epf.employee_pf_contribution
      totals[:employer_share_ac_01] += epf.employer_pf_contribution_ac_01
      totals[:employer_share_ac_10] += epf.employee_pension_ac_10
      totals[:administration_charges_ac_2] += epf.admin_charges_ac_02
      totals[:edli_charges_ac_21] += epf.edli_ac_21
      totals[:edli_admin_charges_ac_22] += epf.edli_admin_ac_22
    end
    totals
  end
end
