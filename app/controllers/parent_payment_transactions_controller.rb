class ParentPaymentTransactionsController < ApplicationController
  load_resource :only => [:print]
  before_action :load_parent_payment_master


  def admin_transactions
    @parent_payment_transactions = ParentPaymentTransaction.all
    @parent_payment_transactions = @parent_payment_transactions.where(:status => params[:status]) if params[:status].present?
    @parent_payment_transactions = @parent_payment_transactions.multi_search_parent_student(params[:search_term]) if params[:search_term].present?
    @parent_payment_transactions = @parent_payment_transactions.transaction_on_or_before(Date.parse(params[:to_date])) if params[:to_date].present?
    @parent_payment_transactions = @parent_payment_transactions.transaction_on_or_after(Date.parse(params[:from_date])) if params[:from_date].present?
    @parent_payment_transactions = @parent_payment_transactions.paginate(:page => params[:page].present? ? params[:page] : 1, :per_page => 20)
    @parent_payment_transactions = ParentPaymentTransactionsDecorator.decorate_collection(@parent_payment_transactions)
  end
  
  def print
    respond_to do |format|
      format.pdf do
        @payment_receipt = PaymentReceipt.new(:branch_abbr => "T", :receipt_date => DateTime.now)
        @payment_receipt.parent_payment_transaction = @parent_payment_transaction
        @parent_payment_transaction = ParentPaymentTransactionsDecorator.decorate(@parent_payment_transaction)
        if @payment_receipt.save!
          render :pdf => "Reciept ",
          :template => 'parent_payment_masters/print_transaction',
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

  def parent_transactions
    respond_to do |format|
      format.json do
        @students = current_user.parent.students
        @transactions = []
        if params[:student_ids].present?
          @students = @students.ids_in_list(params[:student_ids])
        end
        @students.each do |student|
          if student.parent_payment_master.present?
            student.parent_payment_master.parent_payment_transactions.find_each do |transaction|
              @transactions << transaction.attributes.merge!(:student_id => student.id)
            end
          end
        end
        render :json => @transactions
      end
      format.html do
        render "parent_transactions"
      end
    end  
  end

  
  
  private 
  
  def load_parent_payment_master
    @parent_payment_master = ParentPaymentMaster.find(params[:parent_payment_master_id]) if params[:parent_payment_master_id].present?
  end

end
