class DonateBooksController < ApplicationController
  
  def index    
    respond_to do |format|
      format.json do
        @donate_books= DonateBook.all 
        @donate_books = @donate_books.each.map do|donate_book|
          {id: donate_book.id, book_id: donate_book.book_id, name: donate_book.book.name, author: donate_book.book.author, year_of_publishing: donate_book.book.year_of_publishing, number_of_copies: donate_book.book.number_of_copies, book_type: donate_book.book.book_type, isbn: donate_book.book.isbn, student_name: donate_book.student_name, grade_name: donate_book.grade_name, section_name: donate_book.section_name, date_of_donation: donate_book.date_of_donation}
        end       
        render :json => @donate_books
      end      
      format.html do
        @donate_books= DonateBook.all 
      end      
    end
  end
  
end
