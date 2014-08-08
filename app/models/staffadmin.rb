class Staffadmin < ActiveRecord::Base
  validates :dept, :presence => true, :uniqueness => true
end
