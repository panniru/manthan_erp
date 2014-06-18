class ParentChequesController < ApplicationController
  load_resource :only => [:update]
  
  def index
    respond_to do |format|
      format.json do
        @parent_cheques = ParentCheque
        @parent_cheques = @parent_cheques.where(:status => params[:status]) if params[:status].present?
        @parent_cheques = @parent_cheques.multi_search_parent_student_cheque_number(params[:search_term]) if params[:search_term].present?
        @parent_cheques = @parent_cheques.cheques_on_or_before(Date.parse(params[:to_date])) if params[:to_date].present?
        @parent_cheques = @parent_cheques.cheques_on_or_after(Date.parse(params[:from_date])) if params[:from_date].present?
        @parent_cheques = @parent_cheques.limit(30)
        @parent_cheques = ParentChequesDecorator.decorate_collection(@parent_cheques)
        cheques = []
        @parent_cheques.each do |cheque|
          cheques << {:cheque_number => cheque.cheque_number,:parent_name => cheque.parent_name, :student_name => cheque.student_name, :grade => cheque.student_grade, :cheque_date => cheque.cheque_date, :amount_in_rupees => cheque.amount_in_rupees, :id => cheque.id, :status => cheque.status.titleize} 
        end
        render :json => cheques
      end
      format.html do
        render "index"
      end
    end
  end
  
  def update
    respond_to do |format|
      format.json do
        render :json => @parent_cheque.clear_cheque
      end
    end
  end
  
  
  
  def pending_cheques
    @pending_cheques = ParentCheque.pending_cheques
  end


end
