class RequestBook < ActiveRecord::Base
	def self.get_request_books_by_role(current_user) 
		if current_user.admin?
          @request_books = RequestBook.all          
        elsif current_user.librarian?
          @request_books = RequestBook.where('status = '+"'requested'")         
        elsif current_user.teacher?         
          @request_books = RequestBook.where('user_id = '+"'#{current_user.id}'")           
        elsif current_user.parent?
          @request_books = RequestBook.where('user_id = '+"'#{current_user.id}'")         
        elsif current_user.principal?
          @request_books = RequestBook.all          
        end		
	end

	def self.get_pending_requests 
		@pending_request_books = RequestBook.where('status = '+"'pending'")
	end
end
