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

  def update_donate_book
    @donate_book = params[:donate_book]   
    if  @donate_book['id'].present?
      @book = Book.find(@donate_book['book_id'])
      @book.name = @donate_book['name']
      @book.isbn = @donate_book['isbn']      
      @book.author = @donate_book['author']
      @book.year_of_publishing = @donate_book['year_of_publishing']
      @book.number_of_copies = @donate_book['number_of_copies']
      @book.book_type = @donate_book['book_type']
      @book.save
      @d_book = DonateBook.find(@donate_book['id'])
      @d_book.date_of_donation = @donate_book['date_of_donation']
      @d_book.student_name = @donate_book['student_name']
      @d_book.grade_name = @donate_book['grade_name']
      @d_book.section_name = @donate_book['section_name']
      @d_book.save
    end
    render :json => true
  end

  def delete_donate_book
    respond_to do |format|
      format.json do  
        @donate_book = params[:donate_book]  
        p  @donate_book['id']
        p "==============>"
        if  @donate_book['id'].present?
          Book.find(@donate_book['book_id']).destroy
          DonateBook.find(@donate_book['id']).destroy         
        end       
        render :json => true
      end
    end
  end
  
end
