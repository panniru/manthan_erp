class BooksController < ApplicationController
   load_resource :only => [:show, :update, :edit, :destroy]
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
    end
  def index
    @books = Book.all
   
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
  def destroy
    @book = Book.find(params[:id])    
    if @book.destroy
      flash[:success] = I18n.t :success, :scope => [:book, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:book, :destroy]
    end
    redirect_to books_path
  end
  private

  def book_params
    params.require(:book).permit(:name, :isdn, :author, :yop, :noc, :dp,:year)
  end
end
