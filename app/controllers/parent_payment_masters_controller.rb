class ParentPaymentMastersController < ApplicationController
  load_resource :only => [:new, :pending_pdcs, :cleared_pdcs, :update, :payment_transactions, :submitted_pdcs]

  def index
    if current_user.parent?
      @students = current_user.parent.students
      @students = StudentMastersDecorator.decorate_collection(@students)
      render "shared/student_payment_index"
    else
      render "index"
    end
  end
  
  def new
    if params[:student_id].present?
      @parent_payment_master.student_id = params[:student_id]
    end
  end
 
  def create
    unless current_user.parent?
      @parent_payment_master = ParentPaymentMaster.new(parent_payment_master_params)
      @parent_payment_master.parent = @parent_payment_master.student.parent
      payment_creation_service = PaymentCreationService.new(@parent_payment_master, params[:parent_payment_master], DateTime.now)
      if payment_creation_service.save
        @parent_payment_transaction = @parent_payment_master.parent_payment_transactions.last
        @parent_payment_transaction = ParentPaymentTransactionsDecorator.decorate(@parent_payment_transaction)
        render "acknowledgement"
      else
        render "new"
      end
    else
      render "payment_gateway"
    end
  end

  def update
    unless current_user.parent?
      payment_creation_service = PaymentCreationService.new(@parent_payment_master, params[:parent_payment_master], DateTime.now)
      if payment_creation_service.save
        @parent_payment_transaction = @parent_payment_master.parent_payment_transactions.last
        @parent_payment_transaction = ParentPaymentTransactionsDecorator.decorate(@parent_payment_transaction)
        render "acknowledgement"
      else
        render "edit"
      end
    else
      render "payment_gateway"
    end
  end

  def pay
    @parent_payment_master = ParentPaymentMaster.find_by_student_id(params[:student_id])
    if @parent_payment_master.present?
      render "edit"
    else
      @parent_payment_master = ParentPaymentMaster.new_student_payment_master(params[:student_id])
      render "new"
    end
  end

  def pending_pdcs
    respond_to do |format|
      format.json do
        submitted_pdcs = @parent_payment_master.parent_payment_transactions.cheque_type_transactions.pending_transactions.map do |pt|
          Struct.new(:month, :cheque_number, :cheque_date, :amount_in_rupees).new(pt.parent_cheque.post_dated_cheque.month, pt.parent_cheque.cheque_number, pt.parent_cheque.cheque_date, pt.amount_in_rupees)
        end
        render :json => submitted_pdcs
      end
    end
  end

  def cleared_pdcs
    respond_to do |format|
      format.json do
        cleared_pdcs = @parent_payment_master.parent_payment_transactions.cheque_type_transactions.cleared_transactions.map do |ppt|
          Struct.new(:month, :cheque_number, :cleared_date, :amount_in_rupees).new(ppt.parent_cheque.post_dated_cheque.month, ppt.parent_cheque.cheque_number, ppt.transaction_date, ppt.amount_in_rupees)
        end
        render :json => cleared_pdcs
      end
    end
  end

  def submitted_pdcs
    respond_to do |format|
      format.json do
        submitted_pdcs = @parent_payment_master.parent_payment_transactions.cheque_type_transactions.map do |pt|
          Struct.new(:cheque_number, :cheque_date, :amount_in_rupees, :bank_name, :ifsc_code, :status).new(pt.parent_cheque.cheque_number, pt.parent_cheque.cheque_date, pt.amount_in_rupees, pt.parent_cheque.bank_name, pt.parent_cheque.ifsc_code, pt.parent_cheque.status)
        end
        render :json => submitted_pdcs
      end
    end
  end
  
  def payment_transactions
    respond_to do |format|
      format.json do
        render :json => @parent_payment_master.parent_payment_transactions
      end
    end
  end

  def transaction_types
    if current_user.parent?
      @transaction_types = [{value: "online", text: "Online"}]
    else
      @transaction_types = [{value: "cash", text: "CASH"}, {value: "cheque", text: "CHEQUE"}]
    end
    respond_to do |format|
      format.json do
        render :json => @transaction_types
      end
    end
  end
  


  private
  def parent_payment_master_params
    params.require(:parent_payment_master).permit(:payment_type_id, :student_id)
  end
  
end
