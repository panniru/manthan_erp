module Payroll
  class PayslipsAggregation
    attr_accessor :payslips

    def initialize(payslips)
      @payslips = payslips
    end
    
    def get_total_of(attribute)
      atribute_totals[attribute.to_sym]
    end
    def bank_advise_xls(month, year)
      book = Spreadsheet::Workbook.new
      sheet1 = book.create_worksheet :name => "Salary_voucher_#{month}_#{year}"
      sheet1.insert_row(0, [I18n.t(:name, :scope => :organization)])
      sheet1.insert_row(1, [I18n.t(:city, :scope => :organization), I18n.t(:pin, :scope => :organization)])
      sheet1.insert_row(2, ["SALARY PAYMENT FOR THE MONTH OF #{month} #{year}"])
      headers = ["S.NO", "Emp ID", "Name", "Account No", "Amount", "Remarks"]
      sheet1.insert_row(3, headers)
      payslips.each_with_index do |payslip, index|
        row = [index+1, payslip.faculty_master.code, payslip.employee_master.name, payslip.employee_master.account_number, payslip.net_total, "Hochtief - Salary - #{month.to_s[0..2]} #{year.to_s[2..3]}"]
        sheet1.insert_row((3+index+1), row)
      end
      total_row = [nil, nil, "Total", nil, payslips.inject(0){|sum, payslip| sum+payslip.net_total}, nil]
      sheet1.insert_row((4 + payslips.count), total_row)
      format = Spreadsheet::Format.new(:weight => :bold)
      4.times do |x| sheet1.row(x).default_format = format end
      sheet1.row((4 + payslips.count)).default_format = format
      book
    end

    private

    def atribute_totals
      @attribute_totals ||= calculate_totals
    end


    def calculate_totals
      attribute_totals = {}
      payslips.each do |payslip|
        (Payslip::EARNINGS + Payslip::DEDUCTIONS + ["net_total", "total_deductions", "total_earnings", "annual_bonus"]).each do |earning|
          unless attribute_totals[earning.to_sym].present?
            attribute_totals[earning.to_sym] = 0
          end
          attribute_totals[earning.to_sym] =  attribute_totals[earning.to_sym] + payslip.send(earning.to_sym).to_i
        end
      end
      attribute_totals
    end
    
  end
end
