class LibReportsController < ApplicationController
 
  def new
    @lib_report = LibReport.new
  end
  def index
    # @books = Book.all
     @books = Book.all.sort_by &:updated_at
    
  end
  def Leastused
    #@issuings = Issuing.all
    # @issuings = Issuing.group("book").count
    @issuings = Issuing.group("book").count
    
    
  end
 
end
