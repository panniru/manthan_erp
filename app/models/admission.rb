class Admission < ActiveRecord::Base
  validates :dob, presence: true
  validates_format_of :mobile, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/
 
end
