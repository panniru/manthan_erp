class ParentPaymentMastersController < ApplicationController
  load_resource :only => [:new, :pending_pdcs, :cleared_pdcs, :update, :payment_transactions, :submitted_pdcs, :print]

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
    respond_to do |format|
      format.json do
        unless current_user.parent?
          @parent_payment_master = ParentPaymentMaster.new(parent_payment_master_params)
          @parent_payment_master.parent = @parent_payment_master.student.parent
          payment_creation_service = PaymentCreationService.new(@parent_payment_master, params[:parent_payment_master], DateTime.now)
          if payment_creation_service.save
            render :json => {status: true, :parent_payment_master_id => payment_creation_service.parent_payment_master.id, :last_transaction_id => payment_creation_service.last_transaction.id} #"acknowledgement"
          else
            render :json => {status: false, errors: payment_creation_service.errors}
          end
        else
          render "payment_gateway"
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        unless current_user.parent?
          payment_creation_service = PaymentCreationService.new(@parent_payment_master, params[:parent_payment_master], DateTime.now)
          if payment_creation_service.save
            render :json => {status: true, :parent_payment_master_id => payment_creation_service.parent_payment_master.id, :last_transaction_id => payment_creation_service.last_transaction.id} #"acknowledgement"
            
          else
            render :json => {status: false, errors: payment_creation_service.errors}
          end
        else
          render "payment_gateway"
        end
      end
    end
  end

  def pay
    @student_master = StudentMaster.where(:id => params[:student_id]).first if params[:student_id].present? 
    if @student_master.present?
      if ApprovalItem.fee_structure_approved?
        @parent_payment_master = ParentPaymentMaster.find_by_student_id(@student_master.id)
        if @parent_payment_master.present?
          render "edit"
        else
          @parent_payment_master = ParentPaymentMaster.new_student_payment_master(@student_master.id)
          render "new"
        end
      else
        flash[:fail] = I18n.t :pending, :scope => [:approval_items, :fee_structure]
        redirect_to parent_payment_masters_path
      end
    else
      flash[:fail] = I18n.t :not_found, :scope => [:student_master, :search]
      redirect_to parent_payment_masters_path
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

  def student_transactions
    @parent_payment_master = ParentPaymentMaster.find_by_student_id(params[:student_id])
    respond_to do |format|
      format.json do
        data = @parent_payment_master.present? ? @parent_payment_master.parent_payment_transactions.map{|transaction| transaction.attributes} : []
        render :json => data
      end
    end
  end
  
  def print
    respond_to do |format|
      format.pdf do
        @payment_receipt = PaymentReceipt.new(:branch_abbr => "T", :receipt_date => DateTime.now)
        if @payment_receipt.save!
          render :pdf => "Reciept ",
          :template => 'parent_payment_masters/print_monthly_payment_pdcs',
          :formats => [:pdf, :haml],
          :orientation => 'Landscape',
          :page_size  => 'A4',
          :margin => {:top => '8mm',
            :bottom => '8mm',
            :left => '14mm',
            :right => '14mm'}
        end
      end
    end
  end
  

  private
  def parent_payment_master_params
    params.require(:parent_payment_master).permit(:payment_type_id, :student_id)
  end
  
end
