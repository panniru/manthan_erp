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
    @issuing = Issuing.find(params[:id])
  end
  
  def index
    p params
    p "========get method=====================>"
    #@students =  StudentMaster.all
    @issuings = Issuing.all
    p  @issuings
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
  def get_mappings
    respond_to do |format|
      format.json do       
        subjects_grades = GradeSection.all.map do |sg|
          {id: sg.id, grade_master_id: sg.grade_master_id, grade_name: sg.grade_master.grade_name, section_master_id: sg.section_master_id, section_name: sg.section_master.section_name, :union => sg.union } 
        end
        render :json => subjects_grades
      end
    end
  end    
  def get_students
    respond_to do |format|
      format.json  do
        p params[:selected_user]
        a = params[:selected_user].split('-')[0].to_i
        b = params[:selected_user].split('-')[1].to_i
        # subjects = Issuing.select(:book_id,:student_master_id).group_by(&:student_master_id)
        final = []
        data =GradeBook.select(:no_of_books).where(:grade_master_id => a).first
        StudentMaster.where(:grade_master_id => a, :section_master_id => b).each do |student|
          issuings = []
          Issuing.belongs_to_student(student).each do |issuing|
            issuings << {issuing_id: issuing.id, book_id: issuing.book_id, book_name: issuing.book.name,book_issue: issuing.book_issue,book_return_date: issuing.book_return_date,book_issue_date: issuing.book_issue_date}
          end
          (data.no_of_books - issuings.count).times do |i|
            issuings << {issuing_id: nil,book_id: nil, book_name: nil, book_issue: nil,book_return_date: nil,book_issue_date: nil}
          end
          final << {student_id: student.id,student_name: student.name,grade_master_id: student.grade_master_id,section_master_id: student.section_master_id,issuing: issuings}
        end
        p "================"
        p final
        # return data
        render :json => final
      end
    end
  end
 
   
  def save_values
    @new=Issuing.new
    respond_to do |format|
      # p"444444444"
      # p params[:book_return_date]
      # @new.student_master_id = params[:student_id]
      # data = Book.select(:number_of_copies).where(:id => params[:book_id]).first
      # issued = Issuing.select(:book_issue,:book_id).where(book_issue: "Issued",:book_id => params[:book_id]).count(1)
      # returned = Issuing.select(:book_issue,:book_id).where(book_issue: "Returned",:book_id => params[:book_id]).count(1)
      # values = issued - returned
      # p "##############"
      # p values
      # c = (data.number_of_copies.to_i  -  values)
      # p "@@@@@@@@@@@@@"
      # p c
      # if c <= data.number_of_copies.to_i
      #   p c <= data.number_of_copies.to_i
        
      # else
      #   p "1111111111"
      #   flash[:alert] = "Book is not available"
    
      # end
      @new.book_id = params[:book_id].to_i
      @new.book_issue = "Issued"
      @new.grade_master_id = params[:grade_master_id]
      @new.section_master_id = params[:section_master_id]
      @new.book_issue_date =  Date.today
      @new.book_return_date = Issuing.get_no
      @new.save
      render :json => true
    end
  end
  

  def update_values
    @issuing = Issuing.find(params[:issuing_id])
    respond_to do |format|
      if @issuing.update(:book_issue => "Returned")
        format.json { render json:  @issuing , :status => "success"}
      else
        format.json { render json: @issuing , :status => "failure"}
      end
    end
  end
  


  # def get_issuings
  #   respond_to do |format|
  #     format.json do   
  #       subjects = Issuing.select(:id,:book_id,:student_master_id).group_by(&:student_master_id)
  #       p "1111111111111111"
  #       p subjects
  #       data = []
  #       data = subjects.map do |student_id, issuings|
          
  #       end
  #       return data
  #       # {student_master_id: sg.student_master_id,book_id: sg.book_id }
        
  #       # render :json => subjects
  #     end
  #   end
  # end
  def get_issuings
    
    respond_to do |format|
      format.json do       
        @result = Issuing.all.map do |result|
          {id: result.id,book_id: result.book_id,book_name: result.book.name,student_id: result.student_master_id,student_name: result.student_master.name,book_issue_date: result.book_issue_date,book_return_date: result.book_return_date,issue_count: result.issue_count}
        end
        render :json => @result
      end
      
    end
  end
  
  private
    
  def issuing_params
    params.require(:issuing).permit(:name, :grade_master_id, :section_master_id, :student_master_id, :book, :returned_date, :issuing_date, :book_id,:book_issue)
  end
  
end
