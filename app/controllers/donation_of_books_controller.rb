class DonationOfBooksController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]  
  def create
    @donation_of_book = DonationOfBook.new(donation_of_book_params)
    if @donation_of_book.save
      flash[:success] = I18n.t :success, :scope => [:donation_of_book, :create]
      redirect_to donation_of_books_path
    else
      render "new"
    end
    end
  def new
    @donation_of_book = DonationOfBook.new
  end
  
  def index
    @donation_of_books= DonationOfBook.all   
  end
  def show
  end
  def edit
    @donation_of_book = DonationOfBook.find(params[:id])
  end

  def update
    @donation_of_book = DonationOfBook.find(params[:id])
    if @donation_of_book.update(donation_of_book_params)
      flash[:success] = I18n.t :success, :scope => [:donation_of_book, :update]
      redirect_to donation_of_books_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:donation_of_book, :update]
      render "edit"
    end
  end
  def destroy
    @donation_of_book = DonationOfBook.find(params[:id])    
    if @donation_of_book.destroy
      flash[:success] = I18n.t :success, :scope => [:donation_of_book, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:donation_of_book, :destroy]
    end
    redirect_to donation_of_books_path
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
  private
  def donation_of_book_params
    params.require(:donation_of_book).permit(:book_name, :isbn, :year_of_publishing, :number_of_copies,:book_type, :student_name, :section,:grade, :student_master_id, :author)
  end
end
