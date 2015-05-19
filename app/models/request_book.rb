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

  def date
    a = status
    if a == 'Requested'
      y = updated_at
    else 
    end
    p y
    if a == 'Pending'
      y = updated_at
      p y
    else 
    end
    p y
    if a == 'Approved'
      y = updated_at
    else 
    end
    p y
    if a == 'Ordered'
      y = updated_at
    else 
    end
    p y
    if a == 'Delivered'
      y = updated_at
    else 
    end
    p y
  end

  def pending_name
    a = status
    if a == 'Requested'
      y = 'librarian'
    else
    end
    p y
    if a == 'Pending'
      y = 'Principal'
    else
    end
    p y
    if a == 'Approved'
      y = 'Admin'
    else
    end
    p y
    if a == 'Ordered'
      y = 'Vendor'
    else
    end
    p y
    if a == 'delivered'
      y = 'librarian'
    else
    end
    p y
  end
end
