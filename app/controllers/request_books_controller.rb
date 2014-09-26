class RequestBooksController < ApplicationController

  def index
    respond_to do |format|
      format.json do
        @request_books = RequestBook.get_request_books_by_role(current_user)     
        render :json => @request_books
      end
      format.html do
        if current_user.admin?
          render "index"
        elsif current_user.librarian?
          render "librarian_index"
        elsif current_user.teacher?
          render "teacher_index"
        elsif current_user.parent?
          render "parent_index"
        elsif current_user.principal?
          render "principal_index"
        end
      end
    end
  end

  def create
    @request_book = RequestBook.new(request_book_params)
    if @request_book.save
      flash[:success] = I18n.t :success, :scope => [:request_book, :create]
      redirect_to request_books_path
    else
      render "new"
    end
  end

  def pending_request_books
    respond_to do |format|
      format.json do        
        @pending_request_books = RequestBook.get_pending_requests(current_user)  
        render :json => @pending_request_books
      end
      format.html do       
        @pending_request_books = RequestBook.all  
      end
    end
  end

  def delivered_request_books
    respond_to do |format|
      format.json do       
        @delivered_request_books = RequestBook.get_delivered_requests(current_user)  
        render :json => @delivered_request_books
      end 
      format.html do
        @delivered_request_books = RequestBook.get_delivered_requests(current_user)  
      end
    end
  end

  def update_request_books_status
    request_books = params[:resquest_books_status]    
    request_books.each do |t|      
      @request_book = RequestBook.find(t['id'])      
      @request_book.status = t['status']
      @request_book.save
    end    
    render :json => true
  end

  def request_books_mail_to_vendors
    respond_to do |format|
      format.json do          
        RequestBooksMailer.request_book_mail(params[:myMailSubject], params[:myMailMessage],params[:myRequestBooks], ["muralee@ostryalabs.com"]).deliver
        render :json=>true
      end
    end
  end

  private 
  def request_book_params
    params.require(:request_book).permit(:book_name, :author_name, :status, :user_id)
  end
end
