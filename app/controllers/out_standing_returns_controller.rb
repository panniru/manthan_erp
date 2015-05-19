class OutStandingReturnsController < ApplicationController

  def index
    @issuings = Issuing.where(:book_issue => 'Issued').where("book_return_date < ?", Date.today )
    @request_books = RequestBook.all
  end
  
  def new
    @issuing = Issuing.new
  end
end
