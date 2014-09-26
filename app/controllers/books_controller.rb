class BooksController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]

  def index   
    respond_to do |format|
      format.json do  
        if current_user.admin?
          @books = Book.all
          render :json => @books
        elsif current_user.librarian?
          @books = Book.all
          render :json => @books
        end
      end     
      format.html do
        if current_user.admin?
          render "index"
        elsif current_user.librarian?
          render "librarian_index"
        end
      end   
    end 
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = I18n.t :success, :scope => [:book, :create]
      redirect_to books_path
    else
      render "new"
    end
  end
 
  def show
    respond_to do |format|
      format.json do
        render :json => @book
      end
      format.html do
        render "show"
      end
    end
  end
  
  def new
    @book = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = I18n.t :success, :scope => [:book, :update]
      redirect_to books_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:book, :update]
      render "edit"
    end
  end
  
  def create_bulk   
    @book_bulk = build_book_from_bulk
    if !@book_bulk.empty? and @book_bulk.map(&:valid?).all?
      @book_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:book, :create_bulk]
      redirect_to books_path
    else
      flash[:fail] = I18n.t :fail, :scope => [:book, :create_bulk]
      render "new"
    end
  end

  def add_bulk
    @book_bulk = build_book_from_bulk
    if !@book_bulk.empty? and @book_bulk.map(&:valid?).all?
      @book_bulk.each(&:save!)
      delivered_books = params[:bulk_book]
      delivered_books.each do |delivered_book| 
        p @d_book = RequestBook.find(delivered_book['request_book_id']).destroy        
      end
      flash[:success] = I18n.t :success, :scope => [:book, :create_bulk]
      redirect_to pending_request_books_request_books_path
    else
      flash[:fail] = I18n.t :fail, :scope => [:book, :create_bulk]
      render "new"
    end
    
  end

  
  def destroy
    @book = Book.find(params[:id])    
    if @book.destroy
      flash[:success] = I18n.t :success, :scope => [:book, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:book, :destroy]
    end
    redirect_to books_path
  end
  
  def build_book_from_bulk
    params.require(:bulk_book).select{|book| book["name"].present? and  book["isbn"].present?}.map do |book|
      if book[:id].present?
        @book_obj = Book.find(book[:id])
        book.each do |key, val|
          @book_obj.send(key+"=", val) if @book_obj.attributes.include?(key)
        end
        @book_obj
      else
        Book.new(book.permit(:name, :isbn, :author, :year_of_publishing,  :book_type, :purchased_date))
      end
    end
  end

  private
  
  def book_params
    params.require(:book).permit(:name, :isbn, :author, :year_of_publishing, :book_type, :purchased_date)
  end
end
