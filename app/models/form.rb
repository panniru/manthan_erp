class Form < ActiveRecord::Base
 
  validates :dob, presence: true
  validates :mobile_no, presence: true
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i
 
 
end

