class HolidaycalendarsController < ApplicationController
  def empty
  end
  def index
    @holidaycalendars = Holidaycalendar.all
  end
  def new
    @holidaycalendar = Holidaycalendar.new
 end
  def create
    @holidaycalendar = Holidaycalendar.new(holidaycalendar_params)
    if @holidaycalendar.save
      flash[:success] = I18n.t :success, :scope => [:holidaycalendar, :create]
      redirect_to holidaycalendars_path
    else
      render "new"
    end
  end
  def edit
    @holidaycalendar = Holidaycalendar.find(params[:id])
  end
  def update
    @holidaycalendar = Holidaycalendar.find(params[:id])
    respond_to do |format|
      if @holidaycalendar.update(holidaycalendar_params)
        format.html { redirect_to holidaycalendars_path, notice: 'Form was successfully updated.' }
        format.json { render action: 'index', :status => "success" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @holidaycalendar.errors, :status => "failure" }
      end
    end
  end
  def destroy
    @holidaycalendar = Holidaycalendar.find(params[:id])
    @holidaycalendar.destroy
    respond_to do |format|
      format.html { redirect_to holidaycalendars_path }
    end
  end
  def holidaycalendar_params
    params.require(:holidaycalendar).permit(:holiday_date, :description) 
  end
  def holidaycalendardata
    respond_to do |format|
      format.json do
        holiday_calendar = Holidaycalendar.select(:holiday_date).where("trim(to_char(holiday_date, 'Month')) = '#{params[:month]}'").distinct   
        #holiday_calendar = Holidaycalendar.select(:holiday_date).distinct         
        holiday_calendar = holiday_calendar.map do |calendar|
          {start: calendar.holiday_date, title: "holiday", description: "holiday", url: "#", holiday_date: calendar.holiday_date}
      end
        p holiday_calendar
        p "******************"
        render :json => holiday_calendar
      end
      
    end
  end
  def holiday_date
    respond_to do |format|
      format.json do
        holiday_date = Holidaycalendar.where("holiday_date = '#{params[:date]}'")
        holiday_date = holiday_date.map do |holiday|
          {id: holiday.holiday_date, description: holiday.description}
        end
        p holiday_date
        p "&&&&&&&"
        render :json => holiday_date
      end
    end
  end
end
