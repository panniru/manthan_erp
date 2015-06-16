class SectionMaster < ActiveRecord::Base
  belongs_to :grade_section
  belongs_to :grade_master
  has_many :students, :class_name => "StudentMaster"
  validates :section_name, :uniqueness => {:case_sensitive => false}

  def self.get_sections_by_role(current_user)    

    if current_user.role.role == "admin"
      sections = SectionMaster.all.map do |section|
        {section_master_id: section.id, section_name: section.section_name}
      end

    elsif current_user.role.role == "parent"     
      parents_students = StudentMaster.where('parent_master_id = '+"#{current_user.parent.id}")      
      parents_students_grades = parents_students.all.map do |student|
        {section_master_id: student.section_master_id, section_name: student.section_master.section_name, grade_master_id: student.section_master.grade_master_id, student_name: student.name}       
      end
      
    elsif current_user.role.role == "teacher"      
      sections = SectionMaster.all.map do |section|
        {section_master_id: section.id, section_name: section.section_name, grade_master_id: section.grade_master_id, grade_name: section.grade_master.grade_name}
    end 
  elsif current_user.role.role == "principal"      
      sections = GradeSection.all.map do |mapping|
        {section_master_id: mapping.section_master_id, section_name: mapping.section_master.section_name, grade_master_id: mapping.grade_master_id, grade_name: mapping.grade_master.grade_name}
    end 
  end
  end 

end
