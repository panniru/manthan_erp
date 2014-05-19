class FeeType < ActiveRecord::Base
  validates :fee_type, :presence => true
end
