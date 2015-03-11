module Payroll
  class Form24QAnnexure1
    attr_accessor :financial_year, :quarter, :current_user

    def initialize(current_user, financial_year, quarter)
      @financial_year = financial_year
      @quarter = quarter
      @current_user = current_user
    end

    def manage_form24
      generate_form_24_q do |form_24_new, month|
        form_24_new.month = month.month
        form_24_new.year = month.year
        form_24_new.quarter = @quarter
        form_24_new.financial_year = @financial_year
        form_24_new
      end
    end

    def in_the_quarter(quarter)
      @quarter = quarter
      generate_form_24_q
    end

    def generate_form_24_q
      months =  Payroll::FinancialYearCalculator.get_month_dates_in_fin_year_quarter(quarter.to_i, financial_year)
      months.map do |month|
        payslips = Payslip.in_the_month(month.strftime("%b")).in_the_year(month.year.to_s).regulars_manageable_by_user(current_user).pays_tds
        if payslips.count > 0
          form24 = Form24.in_the_month(month.month).in_the_year(month.year).first 
          form24 ||= yield(Form24.new, month) if block_given?
          form24_v_obj = Form24QValueObject.new 
          payslips = PayslipDecorator.decorate_collection(payslips)
          payslips.each do |payslip|
            form24_v_obj.tds = form24_v_obj.tds.to_i + payslip.tds_without_educational_cess
            form24_v_obj.educational_cess = form24_v_obj.educational_cess.to_i + payslip.educational_cess
            form24_v_obj.surcharge = form24_v_obj.surcharge.to_i + payslip.surcharge
            form24_v_obj.total_tax_deposited = form24_v_obj.total_tax_deposited.to_i + payslip.total_tax_calculated
            form24_v_obj.interest = form24_v_obj.interest.to_i + payslip.interest
            form24_v_obj.others = form24_v_obj.others.to_i + payslip.others
          end
          form24_v_obj.challan_serial_no = form24.challan_serial_no
          form24_v_obj.bsr_code = form24.bsr_code
          form24_v_obj.payment_type = form24.payment_type
          form24_v_obj.month = form24.month
          form24_v_obj.year = form24.year
          form24_v_obj.quarter = form24.quarter
          form24_v_obj.id = form24.id
          form24_v_obj.financial_year = form24.financial_year
          form24_v_obj.deposited_date = form24.deposited_date
          form24_v_obj
        end
      end.select{|f| f.present?}
    end

    def month_wise_showcase
      months =  Payroll::FinancialYearCalculator.get_month_dates_in_fin_year_quarter(quarter.to_i, financial_year)
      months.map do |month|
        payslips = Payslip.in_the_month(month.strftime("%b")).in_the_year(month.year.to_s).regulars_manageable_by_user(current_user).pays_tds.sort_on_employee_code
        
        if payslips.count > 0
          form24 = Form24.in_the_month(month.month).in_the_year(month.year).first 
          payslips = PayslipDecorator.decorate_collection(payslips)
          {payslips: payslips, form24: form24, month: month}
        end
      end.select{|f| f.present?}
    end
    


    private

    class Form24QValueObject
      include Virtus.model
      attr_accessor :id
      attr_accessor :tds
      attr_accessor :educational_cess
      attr_accessor :surcharge
      attr_accessor :interest
      attr_accessor :others
      attr_accessor :total_tax_deposited
      attr_accessor :challan_serial_no
      attr_accessor :bsr_code
      attr_accessor :cheque_no
      attr_accessor :deposited_date
      attr_accessor :payment_type
      attr_accessor :month
      attr_accessor :year
      attr_accessor :quarter
      attr_accessor :financial_year

      def to_hash
        {id: id, tds: tds, educational_cess: educational_cess, surcharge: surcharge, interest: interest, others: others, total_tax_deposited: total_tax_deposited, challan_serial_no: challan_serial_no, bsr_code: bsr_code, cheque_no: cheque_no, deposited_date: deposited_date, payment_type: payment_type, month: month, year: year, quarter: quarter, financial_year: financial_year}
      end
    end
  end
end
