class ParentPaymentMaster < ActiveRecord::Base
  validates :payment_type_id, :presence => true
  belongs_to :parent 
  belongs_to :student, :class_name => "StudentHr"
  belongs_to :paymet_type


  def set_next_payment_date
    if self.payement_type.code == "term_wise"
      
    elsif self.payement_type.code == "monthly"
    end
  end
end
