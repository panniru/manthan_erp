class GradeBooksController < ApplicationController

  def get_grades_service
    respond_to do |format|
      format.json do
        grades = GradeMaster.all.map do |grade|
          {grade_name: grade.grade_name, id: grade.id}
        end  
        render :json => grades
      end
    end  
  end
  
  def get_grade_books_service
    respond_to do |format|
      format.json do
        grade_books = GradeBook.all.map do |grade_book|
          {id: grade_book.id, grade_master_id: grade_book.grade_master_id, no_of_books: grade_book.no_of_books}
        end
        render :json => grade_books
      end
    end    
  end
  
  def save_grade_books_service
    mappings = params[:save_grade_book]
    mappings.each do |t|
      if t["id"].present? 
        @mapping = GradeBook.find(t["id"])          
        @mapping.no_of_books = t['no_of_books']
        @mapping.save    
      else
        @mapping = GradeBook.new(add_grade_book_params(t))
        @mapping.save    
      end
    end
    render :json => true
  end
  
  def add_grade_book_params(params)   
    params.permit(:id, :grade_master_id, :no_of_books)
  end
  
end
