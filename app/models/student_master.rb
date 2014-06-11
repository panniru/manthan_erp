class StudentMaster < ActiveRecord::Base
  belongs_to :parent
  belongs_to :grade_master
  has_one :parent_payment_master, :foreign_key => :student_id
end
