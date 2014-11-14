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
        @donate_book = DonateBook.new
        @donate_book.book= Book.new
      end      
    end
  end

  def get_grades
    respond_to do |format|
      format.json do
        grades = GradeMaster.all.map do |grade|
          {grade_name: grade.grade_name, id: grade.id}
        end        
        render :json => grades
      end
    end  
  end

  def get_grade_sections
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

  def get_students
    respond_to do |format|
      format.json do
        students = StudentMaster.where('grade_master_id = '+"'#{params[:my_Grade]}'"+" AND "+'section_master_id = '+"'#{params[:my_Section]}'")
        students = students.each.map do |student|
          {id: student.id, student_name: student.name}
        end       
        render  :json => students
      end
    end  
  end

  def create
    @donate_book = DonateBook.new(donate_book_params)
    respond_to do |format|
      if @donate_book.save
        format.html { redirect_to @donate_book, notice: 'Donate Book was successfully created.' }
        format.json { render action: 'show', status: :created, location: @donate_book }
      else
        format.html { render action: 'new' }
        format.json { render json: @donate_book.errors, status: :unprocessable_entity }
      end
    end    
  end

  def show
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

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def donate_book_params
    params.require(:donate_book).permit(:book_id, :student_name, :grade_name, :section_name, :date_of_donation, :book_attributes =>[:name, :isbn,:author,:isbn,:year_of_publishing,:number_of_copies,:book_type])
  end
  
end
