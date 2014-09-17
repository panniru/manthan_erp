class AttendancesController < ApplicationController
   def save_student_attendance
     params[:attendence_details].each do |t|
       @temp = Attendance.new(add_attendance_params(t))
       @temp.student_master_id = t[:student_master_id]
       @temp.attendance = t[:attendance]
       @temp.attendance_date = t[:attendance_date]
       @temp.save
     end
     render :json => true
   end
  # def save_today_student_attendance
    
  #    params[:attendence_details].each do |t|
  #      @temp = Attendance.new(add_attendance_params(t))
  #      @temp.student_master_id = t[:student_master_id]
  #      @temp.attendance = t[:attendance]
  #      @temp.attendance_date = t[:attendance_date]
  #      @temp.save
  #    end
  #    redirect_to attendances_path
  #  end




  def holidaycalendardata
    respond_to do |format|
      format.json do
        holiday_calendar = Holidaycalendar.select(:holiday_date).distinct   
        #holiday_calendar = Holidaycalendar.select(:holiday_date).distinct         
        holiday_calendar = holiday_calendar.map do |calendar|
          {start: calendar.holiday_date, title: "holiday", description: "holiday", url: "#", holiday_date: calendar.holiday_date}
      end
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
        render :json => holiday_date
      end
    end
  end
  def holidaycalendar_params
    params.require(:holidaycalendar).permit(:holiday_date, :description) 
  end

  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      p "Ruby Controller"
      flash[:success] = I18n.t :success, :scope => [:attendance, :create]
      redirect_to attendances_path
    else
      render "new"
    end
  end
  
  def show
    #@attendance = Attendance.find(params[:id])    
  end

  def index
    if current_user.teacher?
      if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.faculty_master.id}").length != 0)
        @attendance = Attendance.active_at_date
        #render 'index'
        
      end
    end
  end
  def get_students
    respond_to do |format|
      format.json do 
        if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.faculty_master.id}").length != 0)
          pa="#{current_user.faculty_master.id}"
          a = ClassTeacherMapping.where(:faculty_master_id => pa).map{|student| student.grade_master_id}
          students = StudentMaster.where(:grade_master_id => a).each.map do |mapping|
            {id: mapping.id,  grade_master_id: mapping.grade_master_id, section_master_id: mapping.section_master_id, name: mapping.name}
          end     
          render :json => students
        end
  #        end  
   #     end       
      end
    end
  end

            
  def new
    @attendance = Attendance.new
  end
  
  def edit
    @attendance = Attendance.find(params[:id])
  end

  def update
    @attendance = Attendance.find(params[:id])
    if @attendance.update(attendance_params)
      flash[:success] = I18n.t :success, :scope => [:attendance, :update]
      redirect_to attendances_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:attendance, :update]
      render "edit"
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])    
    if @attendance.destroy
      flash[:success] = I18n.t :success, :scope => [:attendance, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:attendance, :destroy]
    end
    redirect_to attendances_path
  end

  private
  def attendance_params
    params.require(:attendance).permit(:name,:attendance,:student_attendance)
  end
  def add_attendance_params(params)
    params.permit(:attendance , :attendance_date)
  end

end
