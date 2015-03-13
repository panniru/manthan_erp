class DepartmentMaster < ActiveRecord::Base
  validates :name, :presence => true
end
