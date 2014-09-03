class TermResultsMailer < ActionMailer::Base
  default from: "principal@example.com"  

  def term_result_mail(s,mail_message,emails,name)    
    @name = name
    @mail_message = mail_message
    mail(to: emails.join(","), subject: s)
  end

end
