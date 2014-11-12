class GradeBooksController < ApplicationController

  def get_grades_service
    respond_to do |format|
      format.json do
        grades = GradeMaster.all.map do |grade|
          {grade_name: grade.grade_name, id: grade.id}
        end  
        p grades
        p "===============>"
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
        p grade_books
        p "===============>"
        render :json => grade_books
      end
    end  
    
  end

end
