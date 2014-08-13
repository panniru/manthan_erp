class RequestNewBooksController < ApplicationController
  def create
    @request_new_book = RequestNewBook.new(request_new_book_params)
    if @request_new_book.save
      flash[:success] = I18n.t :success, :scope => [:request_new_book, :create]
      redirect_to request_new_books_path
    else
      render "new"
    end
  end
  
  def index
    @request_new_books = RequestNewBook.all
  end
  
 def request_new_book
   @request_new_books = RequestNewBook.all
   end
  def show
  end

  def home_request_approval
    @request_new_book = RequestNewBook.find(params[:id])
     if @request_new_book.update(:status => "Approval_Sent" )
       render action: 'home_request_approval'
     else
       render json: @request_new_book.errors
     end
  end

  def new
    @request_new_book = RequestNewBook.new
  end

  def edit
    @request_new_book = RequestNewBook.find(params[:id])
  end
  
  def request_accept
    @request_new_books = RequestNewBook.request_accept
  end
  
  def update
    @request_new_book = RequestNewBook.find(params[:id])
    if @request_new_book.update(request_new_book_params)
      flash[:success] = I18n.t :success, :scope => [:request_new_book, :update]
      redirect_to request_new_books_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:request_new_book, :update]
      render "edit"
    end
  end
  
  def destroy                                      
    @request_new_book = RequestNewBook.find(params[:id])
    if @request_new_book.destroy
      flash[:success] = I18n.t :success, :scope => [:request_new_book, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:request_new_book, :destroy]
    end
    redirect_to request_new_books_path
  end
  
 
  def request_new
    @request_new_books = RequestNewBook.all
  end
  
 
  def request_approval
    
    @request_new_books = RequestNewBook.request_approval
  end
  def suggest_teacher
    @request_new_books = RequestNewBook.all
    end
  def book_accept
    @request_new_books = RequestNewBook.book_accept
    end

  def book_reject
    @request_new_books = RequestNewBook.book_reject
    end
  def book_request_approval
    @request_new_book = RequestNewBook.find(params[:id])
    if @request_new_book.update(:status => "Accepted" )
      render action: 'book_request_approval'
    else
      render json: @request_new_book.errors
    end
    end

  def bookrequest
    @request_new_book = RequestNewBook.find(params[:id])
    if @request_new_book.update(:status => "Rejected" )
      render action: 'bookrequest'
    else
      render json: @request_new_book.errors
    end
  end
  def create_bulk    
    @book_bulk = build_book_from_bulk
    if !@book_bulk.empty? and @book_bulk.map(&:valid?).all?
      @book_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:request_new_book, :create_bulk]
      redirect_to request_new_request_new_books_path
    else
      flash[:fail] = I18n.t :fail, :scope => [:request_new_book, :create_bulk]
      render "new"
    end
  end
   def build_book_from_bulk
     params.require(:bulk_book).select{|request_new_book| request_new_book["book_name"].present? and request_new_book["author_name"].present?}.map do |request_new_book| # RequestNewBook.new(request_new_book.permit(:book_name, :author_name, :status))
       if request_new_book[:id].present?
       @request_new_book_obj = RequestNewBook.find(request_new_book[:id])
        request_new_book.each do |key, val|
        @request_new_book_obj.send(key+"=", val) if @request_new_book_obj.attributes.include?(key)
        end
        @request_new_book_obj
        else
         RequestNewBook.new(request_new_book.permit(:book_name, :author_name, :status))
        end
     end
   end
   
  private
  def request_new_book_params
    params.require(:request_new_book).permit(:book_name, :author_name, :status)
  end
end
