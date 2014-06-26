class JobRunsController < ApplicationController
  load_resource :only => [:show, :failure_recipients]
  
  def index
    @job_runs = JobRun.paginate(:page => params[:page].present? ? params[:page] : 1).order("id DESC")
  end

  def show
  end

  def failure_recipients
    @fee_alert_failures = @job_run.fee_alert_failures
  end
end
