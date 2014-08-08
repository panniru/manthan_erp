class IssuingsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]

  def create
    @issuing = params[:book_issuing_objects]
    
    if BookIssuingFormObject.create_collection(params[:book_issuing_objects])
      flash[:success] = I18n.t :success, :scope => [:issuing, :create]
      redirect_to issuings_path
    else
      render "new"
    end
  end
  
  def show
  end
  
  def index
    @students =  StudentMaster.all
    # @students  = StudentMaster.where("grade_master_id = :grade_master_id AND section_master_id = :section_master_id", {grade_master_id: params[:grade_master_id], section_master_id: params[:section_master_id]})
    @book_issuing_objects = BookIssuingFormObject.build_collection(@students)
    # p "==================="
    # p @book_issuing_objects
  end
   
  
  def gradeserviceview
    respond_to do |format|
      format.json do
        grades = GradeMaster.all.map do |grade|
          {grade_name: grade.grade_name, id: grade.id}
        end
        render :json => grades
      end
    end  
  end
  def new
    @issuing = Issuing.new
  end
  def sectionserviceview
    respond_to do |format|
      format.json do
        get_sections = SectionMaster.all.map do |section|
          {section: section.section_name, id: section.id, grade_master_id: section.grade_master_id }
        end
        render :json => get_sections
      end
    end  
  end  
  def edit
    @issuing = Issuing.find(params[:id])
  end
  def update
    @issuing = Issuing.find(params[:id])
   
    if @issuing.update(issuing_params)
      flash[:success] = I18n.t :success, :scope => [:issuing, :update]
      redirect_to issuings_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:issuing, :update]
      render "edit"
    end
  end
  def destroy
    @issuing = Issuing.find(params[:id])    
    if @issuing.destroy
      flash[:success] = I18n.t :success, :scope => [:issuing, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:issuing, :destroy]
    end
    redirect_to issuings_path
  end

  def student_book_issuings
    respond_to do |format|
      format.json do
        @student = StudentMaster.find(params[:student_id])
        render :json => Issuing.student_book_issuings(@student)
      end
    end
  end
 
  private

  def issuing_params
    params.require(:issuing).permit(:name, :grade, :section, :student_master_id, :book, :deleted_at, :returned_date, :issuing_date)
  end
  
 
end
