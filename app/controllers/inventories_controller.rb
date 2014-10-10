class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all  
  end

  def create

  end

  def edit
  end

  def destroy
  end

  def new
    @inventories = Inventory.order_placed
  end
  
 
  
  def get_inventory_view
    respond_to do |format|
      format.json do 
        inv = Inventory.get_request_by_role(current_user)
        @inventories = inv.each.map do |mapping|
          { id: mapping.id,inventory_type: mapping.inventory_type, name: mapping.name, quantity: mapping.quantity , status: mapping.status}
        end     
        render :json => @inventories
      end
    end
  end
  
  def update_inventory_status
    respond_to do |format|
      format.json do
        status = params[:status]
        status.each do |t|      
          @status = Inventory.find(t['id'])      
          @status.status = t['status']
          @status.save
        end
        render :json => true    
      end
    end
  end
  
  def show
    respond_to do |format|
      format.json do
        render :json => @inventories
      end
      format.html do
      end
    end
  end
  def create_bulk 
    @inventory_bulk = build_inventory_from_bulk
    if !@inventory_bulk.empty? and @inventory_bulk.map(&:valid?).all?
      @inventory_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:inventories, :create_bulk]
      redirect_to inventories_path
    else
      flash[:fail] = I18n.t :fail, :scope => [:inventories, :create_bulk]
      render "index"   
    end
  end

  def request_accept
    @inventory = Inventory.find(params[:id])
    if @inventory.update(:status => "Accepted" )
      render action: 'request_accept'
    else
      render json: @inventory.errors
    end
  end

  def update
    @inventory = Inventory.find(params[:id])
    respond_to do |format|
      if @inventory.update(:status => "Approved")
        format.json { render json: @inventory , :status => "success"}
      else
        format.json { render json: @inventory , :status => "failure"}
      end
    end
  end

  def order_placed
    @inventory = Inventory.find(params[:id])
    respond_to do |format|
      if @inventory.update(:status => "Order placed")
        format.json { render json: @inventory , :status => "success"}
      else
        format.json { render json: @inventory , :status => "failure"}
      end
    end
  end

  def rejected
    @inventory = Inventory.find(params[:id])
    respond_to do |format|
      if @inventory.update(:status => "Rejected")
        format.json { render json: @inventory , :status => "success"}
      else
        format.json { render json: @inventory , :status => "failure"}
      end
    end
  end

  def delivered
    @inventory = Inventory.find(params[:id])
    respond_to do |format|
      if @inventory.update(:status => "Delivered")
        format.json { render json: @inventory , :status => "success"}
      else
        format.json { render json: @inventory , :status => "failure"}
      end
    end
  end

  def refresh
    @inventory = Inventory.find(params[:id])
    respond_to do |format|
      if @inventory.update(:status => "Pending")
        format.json { render json: @inventory , :status => "success"}
      else
        format.json { render json: @inventory , :status => "failure"}
      end
    end
  end
  


  
  def mail_to_vendors
    respond_to do |format|
      format.json do  
        p "==========================="
        p params[:inventories]

        #@inventory = Inventory.find(params[:format])
        UserMailer.vendor(params[:inventories],["navya@ostryalabs.com"]).deliver
        render :json=>true
      end
    end
  end
    
  
  
  def inventory_params
    params.require(:inventories).permit(:name, :inventory_type, :quantity  ) 
  end
  
  def  build_inventory_from_bulk
    params.require(:bulk_inventory).select{|inventory| inventory["name"].present? and inventory["inventory_type"].present? and inventory["quantity"].present?}.map do |inventory| 
      Inventory.new(inventory.permit(:name, :inventory_type, :quantity)) do |inventory|
        inventory.status = 'Pending';
      end
    end
  end
end 
