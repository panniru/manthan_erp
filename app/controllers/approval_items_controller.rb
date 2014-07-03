class ApprovalItemsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy, :approve, :reject]
  
  def index
    respond_to do |format|
      format.json do
        @approval_items = ApprovalItem.all.map do |item|
          item.attributes.merge!(:approved_user => item.approved_user, :defined_user => item.defined_user)
        end
        render :json => @approval_items
      end
      format.html do
        
      end
    end
  end

  def approve
    respond_to do |format|
      format.json do
        if @approval_item.approve(current_user)
          render :json => @approval_item
        end
      end
    end
  end

  def reject
    respond_to do |format|
      format.json do
        if @approval_item.reject
          render :json => @approval_item
        end
      end
    end
  end

  
  def create
    @approval_item = ApprovalItem.new(approval_item_params)
    @approval_item.status =  "pending" 
    @approval_item.academic_year = session[:academic_year] 
    @approval_item.item_type = "fee_structure" 
    @approval_item.defined_by = current_user.id
    respond_to do |format|
      format.json do
        if @approval_item.save
          render json:  @approval_item
        else
          render json: @approval_item 
        end
      end
    end
  end
  

  def fee_structure_approval_item
    respond_to do |format|
      @approval_item = ApprovalItem.find_by_item_type("fee_structure")
      @approval_item = ApprovalItem.new(:item_type => "fee_structure", :status => "new") unless @approval_item.present?
      format.json do
        render :json => @approval_item
      end
    end
  end
 
  def update
    @approval_item = ApprovalItem.find(params[:id])
    respond_to do |format|
      if @approval_item.update(:status => "Approved")
       format.json { render json:  @approval_item , :status => "success"}
      else
        format.json { render json: @approval_item , :status => "failure"}
      end
    end
  end

  private
  def approval_item_params
    params.require(:approval_item).permit(:item_type)
  end
end
