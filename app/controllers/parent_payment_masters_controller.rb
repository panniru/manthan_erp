class ParentPaymentMastersController < ApplicationController
  load_resource :only => [:new]

  def new
    if params[:student_id].present?
      @parent_payment_master.student_id = params[:student_id]
    end
  end
 
  def create
    p "==================>>"
    p params
    @parent_payment_master = ParentPaymentMaster.new(parent_payment_master_params)
    @parent_payment_master.parent = @parent_payment_master.student.parent
    if @parent_payment_master.save!
      
    else
      render "new"
    end
  end


  def 

  private
  def parent_payment_master_params
    params.require(:parent_payment_master).permit(:payment_type_id, :student_id)
  end
  
end
