class StatusController < ApplicationController
  def index
    @request_books = RequestBook.all
  end
end
