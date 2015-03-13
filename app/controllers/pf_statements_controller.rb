class PfStatementsController < ApplicationController
  before_action :load_job_run, :only => [:index]
  authorize_resource
  
  def list_jobs
    page = params[:page].present? ? params[:page] : 1
    @job = Job.matching_code("pf_statement_mailing")
    @job_runs = JobRun.find_by_job(@job).paginate(:page => page).order("job_date DESC")
  end
  
  def index
    respond_to do |format|
      format.html do
        page = params[:page].present? ? params[:page] : 1
        p "1222222"
        p @job_run
        @pf_statements = @job_run.pf_statements.sort_on_employee_code.paginate(:page => page)
        @pf_statements = PfSDecorator.decorate_collection(@pf_statements)
      end
      @pf_statements = @job_run.pf_statements.sort_on_employee_code
      @pf_statements = PfStatementDecorator.decorate_collection(@pf_statements)
      @month = @job_run.job_date.strftime('%b')
      @year = @job_run.job_date.strftime('%Y')
      format.pdf do
        render :pdf => "pf_statement_#{@month}_#{@year}",
        :formats => [:pdf],
        :page_size => 'A4',
        :orientation => 'Landscape'
      end
      format.csv do
        send_data Payroll::PfStatementFormatter.new(@pf_statements).csv(col_sep: "#~#"), :filename=>"pf_statement_#{@month}_#{@year}.txt"
      end
      format.html do
        spreadsheet_data = StringIO.new
        Payroll::PfStatementFormatter.new(@pf_statements).xlsx(@month, @year).write spreadsheet_data
        send_data Payroll::PfStatementFormatter.new(@pf_statements).xlsx(@month, @year).write, :filename=>"pf_statement_#{@month}_#{@year}.xlsx", :type =>  "application/vnd.ms-excel"
      end
    end
  end
  def schedule
    pf_statement_date = PfStatement.pf_statement_applicable_date(session[:transaction_date])
    @month = pf_statement_date.strftime("%b")
    @year = pf_statement_date.strftime("%Y")
    if Payslip.in_the_current_month(pf_statement_date).approved.count > 0
      job = Job.matching_code("pf_statement_mailing")
      job_run = JobRun.find_by_job(job.first.id).in_the_month(@month).in_the_year(@year).first
      unless job_run.present? and (job_run.scheduled? or job_run.finished?)
        pf_job = PfStatementGenerator.new(current_user, pf_statement_date)
        Delayed::Job.enqueue pf_job
        result_link = "<a href=\"/job_runs/#{pf_job.job_run_id}/pf_statements\">here</a>"
        flash[:success] = I18n.t :success, :scope => [:job, :schedule], job: "PF Statement Mailing", job_link: result_link
      else
        result_link = "<a href=\"/job_runs/#{job_run.id}/pf_statements\">here</a>"
        if job_run.scheduled?
          flash[:alert] = I18n.t :already_scheduled, :scope => [:job, :schedule], job: "PF Statement Mailing" , job_link: result_link
        elsif job_run.finished?
          flash[:alert] = I18n.t :already_finished, :scope => [:job, :schedule], job: "PF Statement Mailing", job_link: result_link
        end
      end
    else
      flash[:alert] = "There are no payslips exists/approved for the month #{@month} #{@year}"
    end
    redirect_to pf_statements_list_jobs_path
  end
  def pf_input
    @employee_type = params[:employee_type].present? ? params[:employee_type] : "regular"
    @month = params[:month]
    @year = params[:year]
    @job_run_id = params[:job_run_id]
    payslips = Payslip.manageable_by_user(current_user).in_the_month(@month).in_the_year(@year).all
    @pf_input = PfInput.new(payslips)
    respond_to do |format|
      format.html{}
      format.pdf do
        render :pdf => "pf_statement_#{@month}_#{@year}",
        :formats => [:pdf],
        :page_size => 'A4'
      end
      
    end
  end
  
  private

  def load_job_run
    job = Job.matching_code("pf_statement_mailing")
    @job_run = JobRun.find_by_job(job.first.id).find(params[:job_run_id])
  end
end
