class Form < ActiveRecord::Base
 
  validates :name, :presence => true
  validates :dob, :presence => true
  validates :gender, :presence => true
  validates :email, :presence => true
  validates :mobile_no, :presence => true
  validates :address, :presence => true
  validates :klass, :presence => true
  validates :language, :presence => true
  validates :subject, :presence => true
  validates :experience, :presence => true
  validates :expected_salary, :presence => true
  validates :education_qualification, :presence => true
  validates :nationality, :presence => true
end

