class StudentMastersDecorator < Draper::Decorator
  delegate_all

  def grade
    grade_master.present? ? grade_master.grade_name : nil
  end

  def section
    section_master.present? ? section_master.section : nil
  end

  def to_json(options = {})
    JSON.parse(model.to_json).merge!(:grade => grade, :section => section).to_json
  end
  

end
