class Role < ActiveRecord::Base

  
  def parent?
    code == "parent"
  end

  def teacher?
    code == "teacher"
  end

end
