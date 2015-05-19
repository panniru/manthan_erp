class DefaultMaster < ActiveRecord::Base
  belongs_to :admission
  scope :get_form_no, lambda{where("default_name = 'form_no'")}
  belongs_to :issuing
  scope :get_return_days, lambda{where("default_name = 'return_days'")}
end
