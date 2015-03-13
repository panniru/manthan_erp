class PfStatementDecorator < ApplicationDecorator
  delegate_all

  def member_id
    faculty_master.code
  end

  def member_name
    faculty_master.faculty_name
  end
  
  def fathers_husbands_name	
    faculty_master.father_or_husband_name if new_entrance?
  end

  def relation
    faculty_master.relation if new_entrance?
  end

  def emp_dob
    faculty_master.dob.strftime("%d/%m/%Y") if new_entrance?
  end

  def emp_gender
   faculty_master.gender if new_entrance?
  end

  def doj_epf
    faculty_master.date_of_joining.strftime("%d/%m/%Y") if new_entrance?
  end

  def doj_eps
    doj_epf
  end

  def doe_epf
    faculty_master.resignation_date.strftime("%d/%m/%Y") if exit?
  end

  def doe_eps
    doe_epf
  end

  def r
    faculty_master.reason_for_resignation if exit?
  end

end
