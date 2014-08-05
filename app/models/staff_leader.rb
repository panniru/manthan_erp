class StaffLeader < ActiveRecord::Base
  scope :sports,lambda{where("heads = ' NAVYA-Transport '")}
  scope :closed_forms,lambda{where("status = 'Form_Closed'")}
end
