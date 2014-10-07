class SubjectMastersController < ApplicationController

  def index
    respond_to do |format|
      format.json do         
        @subject_masters = SubjectMaster.all        
        render :json => @subject_masters
      end
      format.html do     
        
      end
    end
  end

  def create_bulk   
    @subject_bulk = build_subject_from_bulk
    if !@subject_bulk.empty? and @subject_bulk.map(&:valid?).all?
      @subject_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:subject_master, :create_bulk]
      redirect_to subject_masters_path
    else
      flash[:fail] = I18n.t :fail, :scope => [:subject_master, :create_bulk]
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
      SubjectMaster.new(inventory.permit(:subject_name))
    end
  end

end
