class ApprovalMailer < ActionMailer::Base
  default :css => 'email'

  def approve_student_route_change(location_master, student)
    @location_master = location_master
    @student = student
    mail(to: "srikanth@ostryalabs.com", subject: "Reg: #{@student.name} Route Change to #{@location_master.location_name}")
  end
  
end
