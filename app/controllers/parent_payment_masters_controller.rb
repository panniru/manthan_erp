class ParentPaymentMastersController < ApplicationController
  load_resource :only => [:new, :submitted_pdcs, :cleared_pdcs, :update, :payment_transactions]

  def new
    if params[:student_id].present?
      @parent_payment_master.student_id = params[:student_id]
    end
  end
 
  def create
    @parent_payment_master = ParentPaymentMaster.prepare_payment_master(params[:parent_payment_master])
    if @parent_payment_master.save!
    else
      render "new"
    end
  end


  def update
    @parent_payment_master.update_parent_payment_master(params[:parent_payment_master]) 
    if @parent_payment_master.save!
    else
      render "edit"
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

  def submitted_pdcs
    respond_to do |format|
      format.json do
        submitted_pdcs = @parent_payment_master.parent_pdcs.map do |pdc|
          Struct.new(:month, :cheque_number, :clearence_date, :amount_in_rupees).new(pdc.post_dated_cheque.month, pdc.cheque_number, pdc.clearence_date, pdc.amount_in_rupees)
        end
        render :json => submitted_pdcs
      end
    end
  end

  def cleared_pdcs
    respond_to do |format|
      format.json do
        cleared_pdcs = @parent_payment_master.parent_payment_transactions.map do |ppt|
          Struct.new(:month, :cheque_number, :cleared_date, :amount_in_rupees).new(ppt.parent_pdc.post_dated_cheque.month, ppt.parent_pdc.cheque_number, ppt.transaction_date, ppt.amount_in_rupees)
        end
        render :json => cleared_pdcs
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

  private
  def parent_payment_master_params
    params.require(:parent_payment_master).permit(:payment_type_id, :student_id)
  end
  
end
