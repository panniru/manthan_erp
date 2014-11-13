class IssuingsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]

  def create
    p params
    p "================post method=================="
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
    p params
    p "========get method=====================>"
    #@students =  StudentMaster.all

     @students  = StudentMaster.where("grade_master_id = :grade_master_id AND section_master_id = :section_master_id", {grade_master_id: params[:grade_master_id], section_master_id: params[:section_master_id]})
    @book_issuing_objects = BookIssuingFormObject.build_collection(@students) 
    p @book_issuing_objects
    p "**************************====>"
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

  def grade_section_service
    respond_to do |format|
      format.json do
        grade_sections = GradeSection.where('grade_master_id = '+"'#{params[:my_Grade]}'")
        grade_sections = grade_sections.each.map do |grade_section|
          {id: grade_section.id, grade_master_id: grade_section.grade_master_id, section_master_id: grade_section.section_master_id, section_name: grade_section.section_master.section_name }
        end       
        render  :json => grade_sections
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
    params.require(:issuing).permit(:name, :grade, :section, :student_master_id, :book, :deleted_at, :returned_date, :issuing_date, :book_id)
  end
  
end
