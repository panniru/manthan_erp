class RequestBook < ActiveRecord::Base
  def self.get_request_books_by_role(current_user) 
    if current_user.admin?
      @request_books = RequestBook.where('status = '+"'Approved'")           
    elsif current_user.librarian?
      @request_books = RequestBook.where('status = '+"'Requested'")         
    elsif current_user.teacher?         
      @request_books = RequestBook.where('user_id = '+"'#{current_user.id}'")           
    elsif current_user.parent?
      @request_books = RequestBook.where('user_id = '+"'#{current_user.id}'")         
    elsif current_user.principal?
      @request_books = RequestBook.where('status = '+"'Pending'"+" OR "+'status = '+"'Approved'"+" OR "+'status = '+"'Rejected'")           
    end		
  end
  
  def self.get_pending_requests(current_user)
    if current_user.librarian?
      @pending_request_books = RequestBook.where('status != '+"'Requested'")   
    end
  end

  def self.get_delivered_requests(current_user)
    if current_user.librarian?
      @pending_request_books = RequestBook.where('status = '+"'Delivered'")   
    end
  end

end
