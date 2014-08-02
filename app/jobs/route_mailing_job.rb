class RouteMailingJob

  def initialize(subject,text)
    @subject = subject
    @text = text
    @job_run_id = JobRun.schedule("route_mailing", subject, text).id
  end
  
  def perform
    @recipients = StudentMaster.where(:bus_facility => true).all
    emails = @recipients.collect(&:father_email).join(",")
    mail(to: emails , subject: @subject )
  end
  begin
    UserMailer.welcome(route_mail[:subject] ,route_mail[:text]).deliver
  rescue Exception => m
    emails.each do |mail|
      begin
        UserMailer.welcome(route_mail[:subject] ,route_mail[:text]).deliver
      rescue Exception => em
        make_failure_entry(mail, em.message, parent)
      end
    end
  end
end


def make_failure_entry(email, remarks, parent)
  RouteFailure.create(:e_mail => email, :job_run_id => @job_run_id, :parent_id => parent.id, :remarks => remarks)
end

def success(job)
  JobRun.finish_as_success(@job_run_id)
end

def error(job, error)
  JobRun.finish_as_error(@job_run_id)
end

def failure(job)
  JobRun.finish_as_failed(@job_run_id)
end

end
