class TermDefinitionsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  
  def index
    @term_definitions = TermDefinition.paginate(:page => params[:page].present? ? params[:page] : 1)
  end

  def update
    if @term_definition.update(term_definition_params)
      flash[:success] = I18n.t :success, :scope => [:term_definition, :update]
      redirect_to term_definitions_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:term_definition, :update]
      render "edit"
    end
  end
  
  def destroy
    if @term_definition.destroy
      flash[:success] = I18n.t :success, :scope => [:term_definition ,:destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:term_definition, :destroy]
    end
    redirect_to term_definitions_path
  end
  
  def edit
  end

  def new
  end
  
  def create_term
    @term_bulk = build_term_from_bulk
    if !@term_bulk.empty? and @term_bulk.map(&:valid?).all?
      @term_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:term_definition, :create_bulk]
      redirect_to term_definitions_path
    else
      flash[:fail] = I18n.t :fail, :scope => [:term_definition, :create_bulk]
      render "new"
    end
  end
  
  private
  
  def term_definition_params
    params.require(:term_definition).permit(:term_definition, :amount_per)
  end
  
  def build_term_from_bulk
    params.require(:bulk_term).select{|term_definition| term_definition["term_definition"].present? and  term_definition["amount_per"].present?}.map do |term_definition|
      TermDefinition.new(term_definition)
    end
  end
  
end
 
  
 
