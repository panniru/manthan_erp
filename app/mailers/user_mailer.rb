class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  def welcome_email
    mail(to: 'navya@ostryalabs.com', subject: 'Welcome to My Awesome Site')
  end
end
