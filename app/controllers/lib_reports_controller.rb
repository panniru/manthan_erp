class LibReportsController < ApplicationController
  def new
    @lib_report = LibReport.new
  end
  def index
    @books = Book.all
   
  end
end
