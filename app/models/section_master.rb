class SectionMaster < ActiveRecord::Base
  belongs_to :grade_master

  def self.get_sections_by_role(current_user)    

    if current_user.role.role == "admin"
      sections = SectionMaster.all.map do |section|
        {section_master_id: section.id, section_name: section.section_name}
      end

    elsif current_user.role.role == "parent"     
      parents_students = StudentMaster.where('parent_id = '+"#{current_user.parent.id}")      
      parents_students_grades = parents_students.all.map do |student|
        {section_master_id: student.section_master_id, section_name: student.section_master.section_name, grade_master_id: student.section_master.grade_master_id, student_name: student.name}       
      end
      
    elsif current_user.role.role == "teacher"      
      sections = SectionMaster.all.map do |section|
        {section_master_id: section.id, section_name: section.section_name, grade_master_id: section.grade_master_id}
    end 
  end
  end 

end
