class PaymentCreationService

  def initialize(parent_payment_master, params, transaction_date)
    @transaction_date = transaction_date
    @parent_payment_master = parent_payment_master
    @parent_payment_master.parent_payment_transactions.concat(payment_transactions(params[:parent_payment_transactions])) 
  end
  
  def save
    @parent_payment_master.save!
  end

  private
  
  def payment_transactions(transaction_params)
    transaction_params.map do |key, params|
      transaction = ParentPaymentTransaction.new(payment_transaction_params(params))
      transaction.transaction_date = @transaction_date;
      if transaction.cheque_payment? or @parent_payment_master.monthly_payment?
        check_type_transaction(transaction, params[:parent_cheque])
      end
      set_status_on_transaction_type(transaction)
      transaction
    end
  end

  def check_type_transaction(transaction, params)
    transaction.parent_cheque = payment_cheque(params) do |cheque|
      cheque.status = "pending"
      transaction.transaction_type = "cheque"
      if @parent_payment_master.monthly_payment?
        cheque.cheque_date = cheque.post_dated_cheque.date
      end
      transaction.particulars = "cheque-"+cheque.cheque_date.to_s
    end
  end
  
  def payment_cheque(cheque_params)
    parent_cheque = ParentCheque.new(payment_cheque_params(cheque_params))
    yield(parent_cheque) if block_given?
    parent_cheque
  end
    
  def set_status_on_transaction_type(transaction)
    if transaction.cash_payment?
      transaction.status = "cleared"
    else
      transaction.status = "pending"
    end
  end

  def payment_master_params(params)
    params.permit(:payment_type_id, :student_id)
  end
  
  def payment_transaction_params(transaction_params)
    transaction_params.slice(:particulars, :term_definition_id, :amount_in_rupees, :transaction_type);
  end
  
  def payment_cheque_params(cheque_params)
    cheque_params.slice(:cheque_number, :bank_name, :ifsc_code, :cheque_date, :post_dated_cheque_id);
  end
  
end
