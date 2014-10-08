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
  def vendor(request_books,emails)
    @inventories = request_books
    p "@@@@@@@@@@@@@@@@@@@@"
    p @inventories
    mail(to: emails.join(",") , subject: "Deliveries" )
  end
end

