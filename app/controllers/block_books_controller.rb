class BlockBooksController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]

  def create
    @block_book = BlockBook.new(block_book_params)
    if @block_book.save
      flash[:success] = I18n.t :success, :scope => [:block_book, :create]
      redirect_to block_books_path
    else
      render "new"
    end
  end
  
  def show
  end
  
  def get_book_service_view
    block = Book.all.map do |block|
      { isbn: block.isbn , name: block.name,author: block.author}
    end
    render :json => block
  end
  
  def index
    @block_books= BlockBook.all
  end

  def new
    @block_book = BlockBook.new
  end

  def edit
    @block_book = BlockBook.find(params[:id])
  end
  
  def update
    @block_book = BlockBook.find(params[:id])
    if @block_book.update(block_book_params)
      flash[:success] = I18n.t :success, :scope => [:block_book, :update]
      redirect_to block_books_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:block_book, :update]
      render "edit"
    end
  end

  def destroy
    @block_book =BlockBook.find(params[:id])
    if @block_book.destroy
      flash[:success] = I18n.t :success, :scope => [:block_book, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:block_book, :destroy]
    end
    redirect_to block_books_path
  end
  
  def getbooks
    block_books = Book.where('isbn = '+"'#{params[:my_Isbn]}'")
    block_books = block_books.map do |block|
      { name: block.name, author: block.author }      
     end
    render :json => block_books
  end

  def savebooks
    block_books = Book.where('isbn = '+"'#{params[:my_Isbn]}'")
    block_books = block_books.map do |block|
      {isbn: block.isbn, name: block.name, author: block.author,blocked_by: params[:my_Block] }
    end
    block_books.each do |t|
      @temp=BlockBook.new()
      @temp.isbn=t[:isbn]
      @temp.name=t[:name]
      @temp.author=t[:author]
      @temp.blocked_by=t[:blocked_by]
      @temp.save
      end
       render :json => block_books
  end

  private 

  def block_book_params
    params.require(:block_book).permit(:isbn,:blocked_by)
  end
end
