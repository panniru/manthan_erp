class GradeMaster < ActiveRecord::Base
  has_many :section_masters

  def self.get_grades_by_role(current_user)    

    if current_user.role.role == "admin"
       grades = GradeMaster.all.map do |grade|
      {grade_master_id: grade.id, grade_name: grade.grade_name}
      end

    elsif current_user.role.role == "parent"     
      parents_students = StudentMaster.where('parent_id = '+"#{current_user.parent.id}")      
      parents_students_grades = parents_students.all.map do |student|
          {grade_master_id: student.grade_master_id, grade_name: student.grade_master.grade_name, student_name: student.name}       
      end
         
    elsif current_user.role.role == "teacher"
      p current_user.faculty_master.id
      p current_user.id
      p "========>"
      teachers = FacultyMaster.where('user_id = '+"#{current_user.id}") 
      p teachers
      p "========>"
      #teachers_grades_sections = TeacherGradeMapping.where('faculty_master_id = '+"#{current_user.faculty_master.id}")

      GradeMaster.all 

    else 

      GradeMaster.all 
    end
    
  end  

end
