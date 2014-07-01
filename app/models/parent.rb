class Parent < ActiveRecord::Base
  has_many :students, :class_name => "StudentMaster"
  belongs_to :user
  has_many :parent_payment_masters

  def parent_name
    return self.father_name if self.father_name.present?
    return self.mother_name if self.mother_name.present?
    return self.guardian_name if self.mother_name.present?
  end
  
  def get_name_from_mail(mail)
    return self.father_name if self.father_email == mail
    return self.mother_name if self.mother_email == mail
    return self.guardian_name if self.guardian_email == mail 
  end

  def student_names 
    students.map{|st| st.name}
  end

  def student_grades
    students.map{|st| st.grade_master.grade_name}
  end

end
