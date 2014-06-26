class TeachersTimeTablesController < ApplicationController
  
  def index
  end

  def get_faculty_names_view
    faulty_names = FacultyMaster.all
    p faulty_names    
    p "-----------------"
    faulty_names = FacultyMaster.all.map do |fn|
      {id: fn.id, name: fn.faculty_name} 
      end
    render :json => faulty_names
    p faulty_names    
    p "-----------------"
  end

  def get_faculty_garde_sections_view
    faulty_grade_sections = TeacherGradeMapping.all
    p faulty_grade_sections   
    p "-----------------"
    faulty_grade_sections = TeacherGradeMapping.all.map do |fgs|
      {id: fgs.faculty_master_id, grade: fgs.grade_master_id, section: fgs.section_master_id, grade_section: fgs.grade_master_id+fgs.section_master_id} 
    end
    render :json => faulty_grade_sections
    p faulty_grade_sections    
    p "-----------------"
        
  end

end
