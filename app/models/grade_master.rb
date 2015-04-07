class GradeMaster < ActiveRecord::Base
  has_many :subject_grades 
  has_many :section_masters
  has_many :grade_sections
  has_many :students, :class_name => "StudentMaster"
  belongs_to :lab_assessment_grade_mapping
  belongs_to :listings
  def self.get_grades_by_role(current_user)    

    if current_user.role.role == "admin"
       grades = GradeMaster.all.map do |grade|
      {grade_master_id: grade.id, grade_name: grade.grade_name}
      end

    elsif current_user.role.role == "parent"     
      parents_students = StudentMaster.where('parent_id = '+"#{current_user.parent.id}")  
      parents_students_grades = parents_students.all.map do |student|
          {grade_master_id: student.grade_master_id, grade_name: student.grade_master.grade_name, section_master_id: student.section_master_id,  section_name: student.section_master.section_name, student_name: student.name}       
      end
         
    elsif current_user.role.role == "teacher"
      teachers_grades_sections =  ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.faculty_master.id}").all.map do |teacher|
        {grade_master_id: teacher.grade_master_id, grade_name: teacher.grade_master.grade_name, section_master_id: teacher.section_master_id,  section_name: teacher.section_master.section_name, faculty_name: current_user.faculty_master.faculty_name}
      end

    else
      GradeMaster.all 
    end
    
  end  

end
