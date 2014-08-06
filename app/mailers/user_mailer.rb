class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  if current_user.admin?
    def welcome(mails, subject, text)
      @subject = subject
      @text = text
      mail(to: mails , subject: @subject )
    end
  elsif current_user.parent?
    def welcome( subject, text)
      @subject = subject
      @text = text
      mail(to: 'navya@ostryalabs.com' , subject: @subject )
    end
  end
end
