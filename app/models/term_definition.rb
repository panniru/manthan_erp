class TermDefinition < ActiveRecord::Base
  has_many :parent_payment_transactions
  
  validates :amount_per, :presence => true, numericality: true
  validates :termdate, :presence => true
end
