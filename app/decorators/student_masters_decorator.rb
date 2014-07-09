class StudentMastersDecorator < Draper::Decorator
  delegate_all

  def grade
    grade_master.present? ? grade_master.grade_name : nil
  end
  
  def section
    section_master.present? ? section_master.section_name : nil
  end

  def to_json(options = {})
    JSON.parse(model.to_json).merge!(:grade => grade, :section => section).to_json
  end
  
  def context_based_url(context)
    if context == "parent_payment_masters"
      "/parent_payment_masters/pay?student_id="+model.id.to_s
    elsif context == "parent_payment_transactions"
    else
    end
  end 

end
