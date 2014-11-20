class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  def welcome(mails, subject, text)
    @subject = subject
    @text = text
    mail(to: mails , subject: @subject )
  end
  def special(mails)
    mail(to: mails , subject: "New Routes" )
  end
  def vendor(mail_subject, mail_message, my_vendor,inventories)
    @mail_message = mail_message  
    @inventories = inventories
    @my_vendor = my_vendor 
    emails = my_vendor["vendor_email"]

    mail(to: emails , subject: mail_subject )
  end
end

