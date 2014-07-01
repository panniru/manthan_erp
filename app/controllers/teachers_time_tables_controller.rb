class TeachersTimeTablesController < ApplicationController
  
  def index
  end

  def get_faculty_names_view
    faulty_names = FacultyMaster.all    
    faulty_names = FacultyMaster.all.map do |fn|
      {id: fn.id, name: fn.faculty_name} 
      end
    render :json => faulty_names    
  end

  def get_faculty_garde_sections_view    
    faulty_grade_sections = TeacherGradeMapping.all.map do |fgs|
      {id: fgs.faculty_master_id, grade: fgs.grade_master.grade_name, section: fgs.section_master.section, grade_section: fgs.grade_master.grade_name+"- "+fgs.section_master.section} 
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
    params[:time_periods].each do |t| 
      if t["id"].present?
        temp=TeachersTimeTable.find(t["id"])
        temp.mon_grade_section=t["mon_grade_section"]
        temp.tue_grade_section=t["tue_grade_section"]
        temp.wed_grade_section=t["wed_grade_section"]
        temp.thu_grade_section=t["thu_grade_section"]
        temp.fri_grade_section=t["fri_grade_section"]
        temp.sat_grade_section=t["sat_grade_section"]
        temp.sun_grade_section=t["sun_rade_section"]
        temp.save
      else
        @timetable=TeachersTimeTable.new(t)
        @timetable.save
      end
    end
  end

  def getperiods    
    teacherstimetables = TeachersTimeTable.where('faculty_master_id = '+"'#{params[:my_Teacher]}'")
    teacherstimetables = teacherstimetables.map do |timetable|
      {id: timetable.id,  mon_grade_section: timetable.mon_grade_section, tue_grade_section: timetable.tue_grade_section, wed_grade_section: timetable.wed_grade_section, thu_grade_section: timetable.thu_grade_section, fri_grade_section: timetable.fri_grade_section, sat_grade_section: timetable.sat_grade_section }
      end    
    render :json => teacherstimetables    
  end
end
