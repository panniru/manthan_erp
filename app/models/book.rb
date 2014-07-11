class Book < ActiveRecord::Base
  validates :name, :presence => true
  validates :isdn, :presence => true
  validates :author, :presence => true
  validates :year_of_publishing, :presence => true
  validates :number_of_copies, :presence => true
 
  validates :book_type, :presence => true
  
end
