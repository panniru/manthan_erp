class ActivityMastersController < ApplicationController
  def index
    respond_to do |format|
      format.json do         
        @activity_masters = SubjectMaster.where(subject_type: "non_academics")
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
              {subject_name: t.subject_name,error: @error_messages}
            end
          end   
          render :json => @emessages
        end 
      end
    end    
  end
  
  def destroy
    @activity = SubjectMaster.find(params[:id])  
    if @activity.destroy
      flash[:success] = I18n.t :success, :scope => [:subject_master, :destroy]
      render :json => true
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:subject_master, :destroy]
    end    
  end
  
  def build_activity_from_bulk
    params.require(:bulk_activity).select{|activity| activity["subject_name"].present?}.map do |act| 
      SubjectMaster.new(act.permit(:subject_name,:subject_type))
    end
  end
  
end
