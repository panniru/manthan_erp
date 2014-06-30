class Form < ActiveRecord::Base
 
  validates :dob, presence: true
  validates :mobile_no, presence: true
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i
 
  
  def self.search(search)
    return scoped unless search.present?
    where(['email LIKE ? OR enquiry_no LIKE ? OR name LIKE ? OR klass LIKE ? OR education_Qualification LIKE ? OR subject LIKE ? ', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  end
end

