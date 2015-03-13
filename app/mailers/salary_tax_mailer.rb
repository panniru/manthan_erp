class SalaryTaxMailer < ActionMailer::Base
  #default from: "from@example.com"

  def salary_tax(salary_tax)
    @faculty_master = salary_tax.faculty_master
    @salary_tax = salary_tax
    financial_year = "#{salary_tax.financial_year_from.year}-#{salary_tax.financial_year_to.year}"
    pdf_str = WickedPdf.new.pdf_from_string(render_to_string(:pdf => "invoice",:template => 'salary_taxes/show.pdf.haml'))
    attachments["SalaryTax_#{financial_year}.pdf"] =  {
      mime_type: 'application/pdf',
      content: pdf_str
    }
    mail(to: @faculty_master.email, subject: "Salary Tax for the financial year #{financial_year}")
  end
  
end
