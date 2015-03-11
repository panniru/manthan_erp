class TaxBucket < ActiveRecord::Base
  validates :from , :presence => true
  validates :tax , :presence => true
end
