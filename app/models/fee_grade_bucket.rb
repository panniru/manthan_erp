class FeeGradeBucket < ActiveRecord::Base
  has_many :grade_wise_fees, :dependent => :destroy
end
