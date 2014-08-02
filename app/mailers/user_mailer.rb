class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  def welcome(subject, text)
    @subject = subject
    @text = text
    StudentMaster.where(:bus_facility => true).each do |x|
      @a = x.parent.father_email
      mail(to: @a , subject: @subject )
    end
  end
end
