class TermDefinitionsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  authorize_resource
  
  def index
    respond_to do |format|
      format.json do
        @term_definitions = TermDefinition.paginate(:page => params[:page].present? ? params[:page] : 1)
        render :json => @term_definitions 
      end
      format.html do
        render "index"
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        render :json => @term_definition.update(term_definition_params)
      end
      format.html do
        if @term_definition.update(term_definition_params)
          flash[:success] = I18n.t :success, :scope => [:term_definition, :update]
          redirect_to term_definitions_path
        else
          flash.now[:fail] = I18n.t :fail, :scope => [:term_definition, :update]
          render "edit"
        end
      end
    end
  end
  
  def destroy
    respond_to do |format|
      format.json do
        render :json => @term_definition.destroy
      end
      format.html do
        if @term_definition.destroy
          flash[:success] = I18n.t :success, :scope => [:term_definition ,:destroy]
        else
          flash.now[:fail] = I18n.t :fail, :scope => [:term_definition, :destroy]
        end
        redirect_to term_definitions_path
      end
    end
  end
  
  def create_bulk
    respond_to do |format|
      @term_bulk = build_term_from_bulk
      format.json do
        status = []
        if !@term_bulk.empty? and @term_bulk.map(&:valid?).all?
          status = @term_bulk.map(&:save!)
        end
        render :json => status
      end
      format.html do
        if !@term_bulk.empty? and @term_bulk.map(&:valid?).all?
          @term_bulk.each(&:save!)
          flash[:success] = I18n.t :success, :scope => [:term_definition, :create_bulk]
          redirect_to term_definitions_path
        else
          flash[:fail] = I18n.t :fail, :scope => [:term_definition, :create_bulk]
          render "new"
        end
      end
    end
  end
  
  private
  
  def term_definition_params
    params.require(:term_definition).permit(:term_definition, :amount_per)
  end

  def term_definition_attributes(param)
    param.permit(:term_definition, :amount_per, :termdate)
  end
  
  
  def build_term_from_bulk
    params.require(:bulk_term).select{|term_definition| term_definition["term_definition"].present? and  term_definition["amount_per"].present?}.map do |term_definition|
      if term_definition[:id].present?
        @term_definition_obj = TermDefinition.find(term_definition[:id])
        term_definition.each do |key, val|
          @term_definition_obj.send(key+"=", val) if @term_definition_obj.attributes.include?(key)
        end
        @term_definition_obj
      else
        TermDefinition.new(term_definition_attributes(term_definition))
      end
    end
  end
  
end
 
  
 
