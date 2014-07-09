class Book < ActiveRecord::Base
  validates :name, :presence => true
  validates :isdn, :presence => true
  validates :author, :presence => true
  validates :year_of_publishing, :presence => true
 
  validates :purchased_date, :presence => true
  
end
