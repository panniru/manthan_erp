class RouteMailingJob

  def initialize(scrolled_by, date, subject,text)
    @scrolled_by = scrolled_by
    @subject = subject
    @text = text
    @job_run_id = JobRun.schedule("route_mailing", scrolled_by, date).id
  end

  def job_run_id
    @job_run_id
  end
  
  def perform
    @email_id_map = {}
    StudentMaster.where(:bus_facility => true).each do |student|
      @email_id_map[student.parent.father_email] = student.parent.id if student.parent.father_email.present?
      @email_id_map[student.parent.mother_email] = student.parent.id if student.parent.mother_email.present?
      @email_id_map[student.parent.guardian_email] = student.parent.id if student.parent.guardian_email.present?
    end
    begin
      @email_id_map.keys.each
      UserMailer.welcome(@email_id_map.keys, @subject, @text).deliver
    rescue Exception => m
      @email_id_map.keys.each do |mail|
        begin
          UserMailer.welcome(mail, @subject, @text).deliver
        rescue Exception => em
          make_failure_entry(mail, em.message, @email_id_map[mail])
        end
      end
    end
  end
  
  def make_failure_entry(email, remarks, parent)
    RouteFailure.create(:e_mail => email, :job_run_id => @job_run_id, :parent_id => parent, :remarks => remarks)
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
