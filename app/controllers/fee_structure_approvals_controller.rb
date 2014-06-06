class FeeStructureApprovalsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  def index
    @fee_structure_approval = FeeStructureApproval.all
  end
  
  def create
    @fee_structure_approval = FeeStructureApproval.new(:status => "pending" ,:academic_year => "2013-14" , :fee_type => "Fee structure" , :defined_by => current_user.user_id , :approved_by => current_user.user_id)
    respond_to do |format|
      if @fee_structure_approval.save
        format.json { render json:  @fee_structure_approval, status: :created}
      else
        format.json { render json: @fee_structure_approval .errors }
      end
    end
  end
 
  def show
  end

  def edit
  end

  def update
    @fee_structure_approval = FeeStructureApproval.find(params[:id])
    respond_to do |format|
      if @fee_structure_approval.update(:status => "Approved")
       format.json { render json:  @fee_structure_approval , :status => "success"}
      else
        format.json { render json: @fee_structure_approval , :status => "failure"}
      end
    end
  end

  def destroy
   
  end

  def new
  end

  def approval_params
    params.require(:fee_structure_approval).permit(:approved_by ,  :defined_by , :status ,:academic_year)
  end
end
