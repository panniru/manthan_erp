class SectionMastersController < ApplicationController
  
  def index
    respond_to do |format|
      format.json do         
        @section_masters = SectionMaster.all        
        render :json => @section_masters
      end
      format.html do     
        
      end
    end
  end

  def create_bulk   
    @section_bulk = build_section_from_bulk
    if !@section_bulk.empty? and @section_bulk.map(&:valid?).all?
      @section_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:section_master, :create_bulk]
      redirect_to section_masters_path
    else
      flash[:fail] = I18n.t :fail, :scope => [:section_master, :create_bulk]
    end    
  end

  def update
    @section = SectionMaster.find(params[:id])
    if @section.update(section_params)
      flash[:success] = I18n.t :success, :scope => [:section_master, :update]   
      render :json => true
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:section_master, :update]     
    end
  end

  def destroy
    @section = SectionMaster.find(params[:id])  
    if @section.destroy
      flash[:success] = I18n.t :success, :scope => [:section_master, :destroy]
      render :json => true
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:section_master, :destroy]
    end    
  end
  
  def build_section_from_bulk
    params.require(:bulk_section).select{|section| section["section_name"].present?}.map do |inventory| 
      SectionMaster.new(inventory.permit(:section_name))
    end
  end

  def section_params
    params.require(:section_master).permit(:section_name)
  end


end
