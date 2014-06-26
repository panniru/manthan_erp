class MailObserver
  def self.delivered_email(message)
    puts "=================================="
    p message
    p "==================================="
  end
end

ActionMailer::Base.register_observer(MailObserver)
