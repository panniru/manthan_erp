require 'rubygems'       
require 'spreadsheet'
require 'roo'
module Payroll
  class PfStatementFormatter
    HEADERS = [:member_id, :member_name, :epf_wages, :eps_wages, :epf_ee_share, :epf_ee_remitted, :eps_due, :eps_remitted, :diff_epf_and_eps, :diff_remitted, :n, :refund_adv, :arrear_epf, :arrear_epf_ee, :arrear_epf_er, :arrear_eps, :fathers_husbands_name, :relation, :emp_dob, :emp_gender, :doj_epf, :doj_eps, :doe_epf, :doe_eps, :r]

    def initialize(pf_statements)
      @pf_statements = pf_statements
    end

    def xlsx(month, year)
      book = Spreadsheet::Workbook.new
      sheet1 = book.create_worksheet :name => "PF statement #{month} #{year}"
      sheet1.insert_row(0, HEADERS.map{|h| h.to_s.titleize})
      @pf_statements.each_with_index do |pf_statement, index|
        sheet1.insert_row(index+1, HEADERS.map{|head| pf_statement.send(head)})
      end 
      book
    end


    def csv(options ={})
      CSV.generate(options) do |csv|
        @pf_statements.each do |pf_statement|
          csv << HEADERS.map{|head| pf_statement.send(head).try(:to_s)} 
        end 
      end
    end
    
    def pdf
    end
  end
end
