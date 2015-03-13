class PayslipDecorator < Draper::Decorator
  delegate_all

  def additional_allowance_1_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_allowance_1
    else
      "additional_allowance_1".titleize
    end
  end

  def additional_allowance_2_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_allowance_2
    else
      "additional_allowance_2".titleize
    end
  end

  def additional_allowance_3_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_allowance_3
    else
      "additional_allowance_3".titleize
    end
  end

  def additional_deduction_1_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_deduction_1
    else
      "additional_deduction_1".titleize
    end
  end

  def additional_deduction_2_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_deduction_1
    else
      "additional_deduction_1".titleize
    end
  end

  def additional_deduction_3_label
    if self.payslip_additional_fields_label.present?
      self.payslip_additional_fields_label.additional_deduction_3
    else
      "additional_deduction_3".titleize
    end
  end

  def tds_without_educational_cess
    ((tds_pm.to_f/final_tax_lap) * income_tax_lap).round
  end

  def educational_cess
    ((tds_without_educational_cess + surcharge) * (SalaryTax.tax_limits[:educational_cess].to_f/100)).round
  end

  def surcharge
    if gross_total_per_year >= SalaryTax.tax_limits[:surcharge_limit]
      ((SalaryTax.tax_limits[:surcharge].to_f/100) *  tds_pm).round
    else
      0
    end
  end

  def total_tax_calculated
    (tds_without_educational_cess + educational_cess + surcharge)
  end

  def interest
    nil.to_i
  end

  def others
    nil.to_i
  end

  def bsr_code
    form24_q_annexure1.try(:bsr_code)
  end

  def tax_deposited_date
    form24_q_annexure1.try(:deposited_date)
  end

  def challan_serial_number
    form24_q_annexure1.try(:challan_serial_no)
  end

  private
  
  def form24_q_annexure1
    @form24 ||= Form24.in_the_month(generated_date.month).in_the_year(generated_date.year).first
  end
  
  def income_tax_lap
    Payroll::SalaryTaxBreakup.income_tax_lap(gross_total_per_year)
  end

  def final_tax_lap
    actual_tax = income_tax_lap
    (actual_tax + ((SalaryTax.tax_limits[:educational_cess].to_f/100) * actual_tax ) + surcharge_percentage)
  end

  def surcharge_percentage
    if gross_total_per_year >= SalaryTax.tax_limits[:surcharge_limit]
      SalaryTax.tax_limits[:surcharge]
    else
      0 
    end
  end

  def gross_total_per_year
    total_earnings * 12
  end

  
end
