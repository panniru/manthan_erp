class TermDefinition < ActiveRecord::Base
  validates :amount_per, :presence => true, numericality: true
  validates :termdate, :presence => true
end
