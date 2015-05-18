class SchoolHousesController < ApplicationController
  def get_school_houses
    respond_to do |format|
      format.json do         
        @designations = SchoolHouse.all
        render :json => @designations
      end
      format.html do     
        
      end
    end
  end
  def index
    respond_to do |format|
      format.json do         
        @designations = SchoolHouse.all
        render :json => @designations
      end
      format.html do     
        
      end
    end
  end

  def show
    @house = SchoolHouse.find(params[:id])  
  end


  def destroy
    @house = SchoolHouse.find(params[:id])  
    if @house.destroy
      # flash[:success] = I18n.t :success, :scope => [:designation, :destroy]
      render :json => true
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:designation, :destroy]
    end    
  end


  def create_bulk   
    respond_to do |format|    
      format.json do 
        @house_bulk = build_house_from_bulk
        if !@house_bulk.empty? and @house_bulk.map(&:valid?).all?
          @house_bulk.each(&:save!)
          # flash[:success] = I18n.t :success, :scope => [:house, :create_bulk]
          render :json=>["success"]
        else 
          @emessages = @house_bulk.each.map do |t|
            if !t.errors.empty?
              @error_messages = t.errors.full_messages
              @error_messages= @error_messages.each.map do |t1|
                {error: t1} 
              end
              {house_name: t.house_name,error: @error_messages}
            end
          end   
          render :json => @error_messages
        end 
      end
    end    
  end
  def build_house_from_bulk
    params.require(:bulk_house).select{|house_name| house_name["house_name"].present?}.map do |params| 
      SchoolHouse.new(params.permit(:house_name))
    end
  end



end
