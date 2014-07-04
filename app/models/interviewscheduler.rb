class Interviewscheduler < ActiveRecord::Base
  scope :interviewschedulers, lambda{where("status = 'form closed'")}
  scope :interviewschedulers, lambda{where("status = 'Assessment Created'")} 
 def self.search(search)
    return scoped unless search.present?
    where(['name LIKE ?  OR description LIKE ? ', "%#{search}%", "%#{search}%"])
  end
end
