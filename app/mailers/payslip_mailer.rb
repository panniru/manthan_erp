class PayslipMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def welcome(email)
    mail(to: 'srikanth@ostryalabs.com', subject: "Testing the production mail settings #{Time.now}")
  end

  def payslip(payslip)
    @faculty_master = payslip.faculty_master
    date = payslip.generated_date
    attachments["Payslip_#{date.strftime('%b')}_#{date.strftime('%Y')}.pdf"] =  {
      mime_type: 'application/pdf',
      content: payslip.pdf.render
    }
    mail(to: @faculty_master.email, subject: "payslip #{date.strftime('%b')} #{date.strftime('%Y')}.pdf")
  end
  
end
