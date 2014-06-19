class ParentPaymentTransactionsController < ApplicationController
  load_resource :only => [:print]
  before_action :load_parent_payment_master
  
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
  
  private 
  
  def load_parent_payment_master
    @parent_payment_master = ParentPaymentMaster.find(params[:parent_payment_master_id])
  end
end
