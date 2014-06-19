class ParentPaymentTransactionsDecorator < Draper::Decorator
  delegate_all
  
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
