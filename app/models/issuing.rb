class Issuing < ActiveRecord::Base
 
  attr_accessor :is_returned
  belongs_to :book
  belongs_to :student_master
  has_one :default_master
  
  belongs_to :student, :class_name => "StudentMaster"
   
  scope :belongs_to_student, lambda{|student| where(:student_master_id => student)}
    
  def self.student_book_issuings(student)
    Issuing.joins(:book).select("issuings.id", "issuings.book_issue_date", "issuings.book_return_date", "books.name").belongs_to_student(student).order("issuings.book_issue_date DESC").group_by{|b| b.book.name}
  end

  def self.get_no
    a = DefaultMaster.get_return_days.map(&:default_value).first
    p "@@@@@@@@@@@@@@@@@"
    p a
    book_returned = a.to_i
    p "1111111111111"
    p book_returned
    a = Date.today + book_returned
    p "******"
    p a
    return a
  end

  def issue_count
    
    p book_return_date
   
    b = book_return_date
    c = Date.today
    a =(b..c).to_a
    a =(b..c).to_a.count-2
    if c > b
      z = c > b
      d = a
    else
      d = "Not Yet Completed"
    end
    return d
  end
end
  


 
