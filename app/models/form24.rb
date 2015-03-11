class Form24 < ActiveRecord::Base
  scope :in_the_quarter, lambda{|quarter| where(:quarter => quarter)}
  scope :in_the_financial_year, lambda{|year| where(:financial_year => year)}
  scope :in_the_year, lambda{|year| where("year = ?", year)}
  scope :in_the_month, lambda{|month| where("month = ?", month)}

  def self.get_date
    a =  (Date.today.year-10..Date.today.year).map{|year| "#{year}-#{year+1}"}
  end

  def form24_in_the_quarter(quarter, date, current_user)
    months = Payroll::FinancialYearCalculator.new(date).get_months_in_quarter(quarter)
    months.map do |month|
      form24_v_obj = Form24QValueObject.new
      payslips = Payslip.in_the_month(month.strftime("%b")).regulars_manageable_by_user(current_user).pays_tds
      payslips = PayslipDecorator.decorate_collection(payslips)
      payslips.each do |payslip|
        form24_v_obj.tds = form24_v_obj.tds.to_i + payslip.tds_without_educational_cess
        form24_v_obj.educational_cess = form24_v_obj.educational_cess.to_i + payslip.educational_cess
        form24_v_obj.surcharge = form24_v_obj.surcharge.to_i + payslip.surcharge
        form24_v_obj.total_tax_deposited = form24_v_obj.total_tax_deposited.to_i + payslip.total_tax_calculated
        form24_v_obj.interest = form24_v_obj.interest.to_i + payslip.interest
        form24_v_obj.others = form24_v_obj.others.to_i + payslip.others
      end
      form24_v_obj.challan_serial_no = challan_serial_no
      form24_v_obj.bsr_code = bsr_code
      form24_v_obj.payment_type = payment_type
      form24_v_obj.month = date.month
      form24_v_obj.year = date.year
    end
  end
end
