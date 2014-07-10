class UserMailer1 < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer1.new_user.subject
  #
  def new_user
    @greeting = "Hi"

    mail to: "to@example.org"
  end
  def sent_approval
  
  end
end
