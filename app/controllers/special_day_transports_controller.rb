class SpecialDayTransportsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json
  def index
    @special_day_transports = SpecialDayTransport.select('DISTINCT occation,date')

  end
  
  def create
    params[:bulk_save].each do |n|
      @new =  SpecialDayTransport.new(:date => params[:date] , :occation => params[:occation])
      @new.location_master_id = n[:location_master_id]
      @new.route_id = n[:route_id]
      @new.time_up = n[:time_up]
      @new.new_up_route = n[:new_up_route]
      @new.new_busno_up = n[:new_busno_up]
      @new.time_down = n[:time_down]
      @new.new_down_route = n[:new_down_route]
      @new.new_busno_down = n[:new_busno_down]
      @new.save
    end
    redirect_to  special_day_transports_path  
  end

  def new
    @locations = Location.all
    #select('DISTINCT location_master_id') 
  end

  def send_mail
    @special_day_transports = SpecialDayTransport.where(:occation => params[:occation])
    respond_to do |format|
      mailing_job = SpecialRouteMailingJob.new(current_user.user_id, DateTime.now) 
      Delayed::Job.enqueue mailing_job, mailing_job.job_run_id
      result_link = "<a href=\"/job_runs/#{mailing_job.job_run_id}\">here</a>"
      msg = I18n.t :success, :scope => [:job, :schedule], job: "Special Route Mailing Job", result_link: result_link
      format.json do
        render :json => msg
      end
      format.html do
        flash[:success] = msg.html_safe
        redirect_to special_day_transports_path
      end
    end 
  end
  
  def create_bulk
    @route_bulk = build_route_from_bulk
    if !@route_bulk.empty? and @route_bulk.map(&:valid?).all?
      @route_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:special_day_transports, :create_bulk]
      redirect_to special_day_transports_path
    else
      flash[:fail] = I18n.t :fail, :scope => [:special_day_transports, :create_bulk]
      render "new"
    end
  end
  
  def occations
    @special_day_transports = SpecialDayTransport.where(:occation => params[:occation])
    @locations= Location.select('DISTINCT location_master_id')
  end
 
  def show
  end
  
  def update
    @special_day_transports = SpecialDayTransport.find(params[:id])
    respond_to do |format|
      if @special_day_transports.update(route_params)
        format.html { redirect_to special_day_transports_path, notice: ' successfully updated.' }
        format.json { render action: 'index', :status => "success" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @special_day_transport.errors, :status => "failure" }
      end
    end
  end
  def edit
    @special_day_transports = SpecialDayTransport.find(params[:id])
  end
  
  private
  
  def build_route_from_bulk
    params.require(:bulk_save).select{|routes| routes["new_route_no"].present? and routes["time_up"].present? and routes["new_up_route"].present? and routes["new_busno_up"].present? and routes["time_down"].present? and routes["new_down_route"].present? and routes["new_busno_down"].present?}.map do |route|
      SpecialDayTransport.new(special_day_transport.permit(:new_route_no , :time_up, :new_up_route, :new_busno_up , :time_down , :new_down_route , :new_busno_down ))
   
    end
  end
  
  def route_params
    route_params = params.require(:special_day_transport).permit( :date, :occation,:new_route_no , :time_up, :new_up_route, :new_busno_up , :time_down , :new_down_route , :new_busno_down )
  end
end
