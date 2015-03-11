class DesignationsController < ApplicationController
  def index
    respond_to do |format|
      format.json do         
        @designations = Designation.all
        render :json => @designations
      end
      format.html do     
        
      end
    end
  end

  def show
    @designation = Designation.find(params[:id])
  end


  def create_bulk   
    respond_to do |format|    
      format.json do 
        @designation_bulk = build_designation_from_bulk
        if !@designation_bulk.empty? and @designation_bulk.map(&:valid?).all?
          @designation_bulk.each(&:save!)
          # flash[:success] = I18n.t :success, :scope => [:designation, :create_bulk]
          render :json=>["success"]
        else 
          @emessages = @designation_bulk.each.map do |t|
            if !t.errors.empty?
              @error_messages = t.errors.full_messages
              @error_messages= @error_messages.each.map do |t1|
                {error: t1} 
              end
              {designation: t.designation,error: @error_messages}
            end
          end   
          render :json => @error_messages
        end 
      end
    end    
  end
 
  def destroy
    @designation = Designation.find(params[:id])  
    if @designation.destroy
      # flash[:success] = I18n.t :success, :scope => [:designation, :destroy]
      render :json => true
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:designation, :destroy]
    end    
  end
  
  def build_designation_from_bulk
    params.require(:bulk_designation).select{|designation| designation["designation"].present?}.map do |params| 
      Designation.new(params.permit(:designation))
    end
  end

end
