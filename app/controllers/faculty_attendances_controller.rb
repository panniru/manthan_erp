class FacultyAttendancesController < ApplicationController
  def get_faculties
    respond_to do |format|
      format.json do
        facultys = FacultyMaster.all.each.map do  |mapping|
          {faculty_master_id: mapping.id, name: mapping.faculty_name, designation: mapping.designation}
        end
        render :json => facultys
      end
    end
  end


  def get_faculty
    hash = FacultyAttendance.get_faculty_names
    respond_to do |format|
      format.json do
        render :json => hash
      end
     format.html do
        render "index"
      end
    end
  end

  def get_faculty_designation
    p params[:designation]
    hash = FacultyAttendance.get_faculty_design(params[:designation])
    respond_to do |format|
      format.json do
        render :json => hash
      end
      format.html do
        render "index"
      end
    end
  end

  def attendance_on_date
    p params[:designation]
    p params[:date]
    respond_to do |format|
      format.json do
        render :json => StaffAttendance::FacultyAttendan.attendance_on_date(params[:date], params[:designation])
      end
    end
  end


  def save_today_attendance
    p "111111111122222222222"
    p params[:save_today_attendence]
    respond_to do |format|
         format.json do 
        attendence_details = params[:save_today_attendence]
        attendence_details.each do |i|
          if i[:id].present?
            @temp = FacultyAttendance.find(i[:id])
            @temp.forenoon = i["forenoon"]
            @temp.attendance_date = i["attendance_date"]
            @temp.name = i["name"]
            @temp.designation = i["designation"]
            @temp.faculty_master_id = i["faculty_master_id"]
            @temp.save
           else
            @temp = FacultyAttendance.new(add_attendance_params(i))
            @temp.forenoon = i[:forenoon]
            @temp.attendance_date = i[:attendance_date]
            @temp.name = i[:name]
            @temp.designation = i[:designation]
            @temp.faculty_master_id = i[:faculty_master_id]
            @temp.save
          end
         end
           redirect_to faculty_attendances_path
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
  def add_attendance_params(params)
    params.permit(:forenoon , :attendance_date, :name, :faculty_master_id, :designation)
  end

end
