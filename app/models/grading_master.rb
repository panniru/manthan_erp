class GradingMaster < ActiveRecord::Base
  validates :grading_name, uniqueness: true, :presence => {:message => 'Name cannot be blank, Task not saved'}
end
