class ParentPaymentTransactionsDecorator < ApplicationDecorator
  delegate_all
  
  def student_name
    parent_payment_master.student.name
  end

  def parent_name
    parent_payment_master.parent.parent_name
  end

  def student_grade
    parent_payment_master.student.grade_master.grade_name
  end
  
  def payment_mode
  end

  def bank_name
    if transaction_type == "cheque"
      parent_cheque.bank_name
    else
      "--"
    end
  end

  def ref_no
    if transaction_type == "cheque"
      parent_cheque.cheque_number
    else
      "--"
    end
  end

end
