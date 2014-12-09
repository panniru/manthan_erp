class AttendancesController < ApplicationController
  
  def group_month
    groups = Attendance.grouping_month(params[:date], current_user.faculty_master)
    respond_to do |format|
      format.json do
        render :json => groups
      end
    end
  end

  def get_month
    groups = Attendance.get_month(params[:month], current_user.faculty_master)
    respond_to do |format|
      format.json do
        render :json => groups
      end
    end
  end
  
  

  def get_week
    respond_to do |format|
      format.json do
        render :json => StudentReport::Attendence.this_week
        p params
      end
    end
  end
   
  def attendance_on_date
    respond_to do |format|
      format.json do
        render :json => StudentReport::Attendence.students_attendance_on_date(params[:date], current_user.faculty_master)
        p params[:date]
      end
    end
  end

  def show_attendance
    hash = Attendance.this_week(params[:date], current_user.faculty_master)
    respond_to do |format|
      format.json do 
        render :json => hash
      end
      format.html do 
        render "show_week"
      end
    end
  end
  
  def monthly_attendance
    
    @month = Attendance.attendance_details(params[:date], current_user.faculty_master)
    respond_to do |format|
      format.json do 
        render :json => @month
      end
      format.html do 
        render "monthly_attendance"
      end
    end
  end
  def show
  end
  
   def save_today_student_attendance
     p params[:save_today_attendence_details]
     respond_to do |format|
       format.json do 
         attendence_details = params[:save_today_attendence_details]
         attendence_details.each do |i|
           if i[:id].present?
             @temp = Attendance.find(i[:id])
             @temp.student_master_id = i["student_master_id"]
             @temp.attendance = i["attendance"]
             @temp.attendance_date = i["attendance_date"]
             @temp.faculty_master_id = i["faculty_master_id"]
             @temp.name = i["name"]
             @temp.save
           else
             @temp = Attendance.new(add_attendance_params(i))
             @temp.student_master_id = i[:student_master_id]
             @temp.attendance = i[:attendance]
             @temp.attendance_date = i[:attendance_date]
             @temp.faculty_master_id = i[:faculty_master_id]
             @temp.name = i[:name]
             @temp.save
           end
         end
           redirect_to attendances_path
       end
     end
   end

     def holidaycalendardata
       respond_to do |format|
         format.json do
           holiday_calendar = Holidaycalendar.select(:holiday_date).distinct   
           holiday_calendar = holiday_calendar.map do |calendar|
             {start: calendar.holiday_date, end: calendar.holiday_date,title: "holiday", description: "holiday", url: "#", holiday_date: calendar.holiday_date}
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
    
    respond_to do |format|
      format.json do
        render :json => StudentReport::Attendence.students_attendance_on_date(params[:date], current_user.faculty_master)
        p params[:date]
      end
      format.html do
        render "index"
      end
    end
  end
  
    def get_students
    respond_to do |format|
      format.json do 
        if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.faculty_master.id}").length != 0)
          pa="#{current_user.faculty_master.id}"
          a = ClassTeacherMapping.where(:faculty_master_id => pa).map{|student| student.grade_master_id}
          b = ClassTeacherMapping.where(:faculty_master_id => pa).map{|student| student.section_master_id}
          students = StudentMaster.where(:grade_master_id => a, :section_master_id => b).each.map do |mapping|
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
    respond_to do |format|
      if @attendance.update(add_attendance_params)
        format.html { redirect_to attendances_path }
        format.json { render action: 'index'}
      end
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
    params.permit(:attendance , :attendance_date, :faculty_master_id, :student_master_id, :name, :student_attendance)
  end

end
