class Interviewscheduler < ActiveRecord::Base
  scope :interviewschedulers, lambda{where("status = 'form closed'")}
  scope :interviewschedulers, lambda{where("status = 'Assessment Created'")} 
    
end
