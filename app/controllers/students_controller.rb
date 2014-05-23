class StudentsController < ApplicationController
  def get_selected
    redirect_to students_index_path  
  end
  def get_students
    render "app_students"
  end
  def app_students
  
  end
    
    def create
     @student = Student.new(student_params)
     if @student.save
       flash.now[:success] = I18n.t :success, :scope => [:student, :create]
       redirect_to students_path
     else
       flash.now[:fail] = I18n.t :fail, :scope => [:student, :create]
       render "new"
     end
   end
   
   def index
    @students = Student.all
   end
   
   def new
     @student = Student.new
   end
   
   def edit
     @student = Student.find(params[:id])
   end
   def show
     
   end
   
   def update
     @student = Student.find(params[:id])
     respond_to do |format|
       if @student.update(student_params)
         format.html { redirect_to students_path, notice: 'Form was successfully updated.' }
         
       else
         format.html { render action: 'edit' }
         
       end
     end
   end
   
   def destroy
     @student = Student.find(params[:id])
     @student.destroy
     respond_to do |format|
       format.html { redirect_to students_url }
     end
   end
   private
   def student_params
     params.require(:student).permit(:form_no,:name, :klass, :gender, :language, :dob, :nationality, :father_name, :mother_name, :father_occupation, :mother_occupation, :father_company, :mother_company, :father_education, :mother_education, :income, :address, :landline, :mobile, :email, :transport, :busstop, :last_school, :city, :changing_reason, :person, :pp, :know_school, :status)
  end
   
 end
 
