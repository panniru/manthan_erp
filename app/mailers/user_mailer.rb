class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  def welcome(mails, subject, text)
    @subject = subject
    @text = text
    mail(to: mails , subject: @subject )
  end
end
