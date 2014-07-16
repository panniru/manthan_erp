class GradeMaster < ActiveRecord::Base
  has_many :section_masters

  def self.get_grades_by_role(current_user)

    p current_user.role_id
    p current_user.role.id
    p current_user.role.role

    if current_user.role.role == "admin"
       GradeMaster.all
    elsif current_user.role.role == "parent"
      GradeMaster.all
    elsif current_user.role.role == "teacher"
      GradeMaster.all 
    else 
      GradeMaster.all 
    end
    
  end  

end
