class ParentChequesDecorator < Draper::Decorator
  delegate_all
  
  def student_name
    parent_payment_transaction.parent_payment_master.student.name
  end

  def parent_name
    parent_payment_transaction.parent_payment_master.parent.parent_name
  end

  def student_grade
    parent_payment_transaction.parent_payment_master.student.grade_master.grade_name
  end

  def amount_in_rupees
    parent_payment_transaction.amount_in_rupees
  end

  
end
