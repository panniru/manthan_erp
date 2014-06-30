class Admission < ActiveRecord::Base
  validates :dob, presence: true
  validates_format_of :mobile, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :father_email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :mother_email, presence: true, format: { with: VALID_EMAIL_REGEX }


  def self.search(search)
    return scoped unless search.present?
    where(['admission_no LIKE ? OR form_no LIKE ? OR name LIKE ? OR klass LIKE ?  OR father_name LIKE ? OR mobile LIKE ?  ', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  end
end
