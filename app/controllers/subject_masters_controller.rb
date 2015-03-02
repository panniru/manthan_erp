class SubjectMastersController < ApplicationController

  def index
    respond_to do |format|
      format.json do         
        @subject_masters = SubjectMaster.where(subject_type: "academics")      
        render :json => @subject_masters
      end
      format.html do     
        
      end
    end
  end

  def create_bulk   
    respond_to do |format|    
      format.json do 
        @subject_bulk = build_subject_from_bulk
        if !@subject_bulk.empty? and @subject_bulk.map(&:valid?).all?
          @subject_bulk.each(&:save!)
          flash[:success] = I18n.t :success, :scope => [:subject_master, :create_bulk]
          render :json=>["success"]
        else 
          @emessages = @subject_bulk.each.map do |t|
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
    @subject = SubjectMaster.find(params[:id])  
    if @subject.destroy
      flash[:success] = I18n.t :success, :scope => [:subject_master, :destroy]
      render :json => true
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:subject_master, :destroy]
    end    
  end
  
  def build_subject_from_bulk
    params.require(:bulk_subject).select{|subject| subject["subject_name"].present?}.map do |inventory| 
      SubjectMaster.new(inventory.permit(:subject_name, :subject_type))
    end
  end

end
