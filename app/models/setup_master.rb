class SetupMaster < ActiveRecord::Base
  validates :designation, :presence => true, :uniqueness => true
end
