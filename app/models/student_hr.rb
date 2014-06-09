class StudentHr < ActiveRecord::Base
  belongs_to :parent
  has_one :parent_payment_master, :foreign_key => :student_id
end
