class ActivityMastersController < ApplicationController
  def index
    respond_to do |format|
      format.json do         
        @activity_masters = ActivityMaster.all        
        render :json => @activity_masters
      end
      format.html do        
      end
    end
  end

  def create_bulk   
    respond_to do |format|    
      format.json do 
        @activity_bulk = build_activity_from_bulk
        if !@activity_bulk.empty? and @activity_bulk.map(&:valid?).all?
          @activity_bulk.each(&:save!)
          flash[:success] = I18n.t :success, :scope => [:activity_master, :create_bulk]
          render :json=>["success"]
        else 
          @emessages = @activity_bulk.each.map do |t|
            if !t.errors.empty?
              @error_messages = t.errors.full_messages
              @error_messages= @error_messages.each.map do |t1|
                {error: t1} 
              end
              {activity_name: t.activity_name,error: @error_messages}
            end
          end   
          render :json => @emessages
        end 
      end
    end    
  end
  
  def destroy
    @activity = ActivityMaster.find(params[:id])  
    if @activity.destroy
      flash[:success] = I18n.t :success, :scope => [:activity_master, :destroy]
      render :json => true
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:activity_master, :destroy]
    end    
  end
  
  def build_activity_from_bulk
    params.require(:bulk_activity).select{|activity| activity["activity_name"].present?}.map do |act| 
      ActivityMaster.new(act.permit(:activity_name))
    end
  end
  
end
