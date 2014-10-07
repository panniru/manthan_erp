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
    @request_books = request_books
    mail(to: emails.join(",") , subject: "Deliveries" )
  end
end

