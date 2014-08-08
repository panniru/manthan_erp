class TeachersTimeTablesController < ApplicationController
  
  def index
    if current_user.admin?
      render "index"    
    elsif  current_user.teacher?
      @fm = FacultyMaster.new
      render "teacher_index"
    end
  end

  def get_faculty_names_view
    faculty_names = FacultyMaster.get_faculty_names_by_role(current_user)    
    render :json => faculty_names    
  end

  def get_faculty_garde_sections_view    
    faulty_grade_sections = TeacherGradeMapping.all.map do |fgs|
      {id: fgs.faculty_master_id, grade: fgs.grade_master.grade_name, section: fgs.section_master.section_name, grade_section: fgs.grade_master.grade_name+"- "+fgs.section_master.section_name} 
    end
    render :json => faulty_grade_sections
  end

  def check_teachers_timetable
    respond_to do |format|
      format.json do
        teacherstimetables = TeachersTimeTable.where('faculty_master_id = '+"#{params[:my_Teacher]}").count 
        render :json => teacherstimetables
      end
    end  
  end

  def saveperiods    
    respond_to do |format|
      format.json do   
        params[:time_periods].each do |t| 
          if t["id"].present?
            temp=TeachersTimeTable.find(t["id"])
            temp.mon_grade_section=t["mon_grade_section"]
            temp.tue_grade_section=t["tue_grade_section"]
            temp.wed_grade_section=t["wed_grade_section"]
            temp.thu_grade_section=t["thu_grade_section"]
            temp.fri_grade_section=t["fri_grade_section"]
            temp.sat_grade_section=t["sat_grade_section"]
            temp.sat_grade_section=t["sun_grade_section"]            
            temp.save
          else
            @timetable=TeachersTimeTable.new(add_params(t))
            @timetable.save
          end
        end      
      end
      render :json => true
    end
  end

  def getperiods    
    
    teacherstimetables = TeachersTimeTable.where('faculty_master_id = '+"'#{params[:my_Teacher]}'")
    teacherstimetables = teacherstimetables.map do |timetable|
      {id: timetable.id,  mon_grade_section: timetable.mon_grade_section, tue_grade_section: timetable.tue_grade_section, wed_grade_section: timetable.wed_grade_section, thu_grade_section: timetable.thu_grade_section, fri_grade_section: timetable.fri_grade_section, sat_grade_section: timetable.sat_grade_section }
      end    
    render :json => teacherstimetables  
    
  end

   def add_params(params)
    params.permit(:id, :faculty_master_id, :mon_grade_section, :tue_grade_section, :wed_grade_section, :thu_grade_section, :fri_grade_section, :sat_grade_section, :sun_grade_section)
   end
end
