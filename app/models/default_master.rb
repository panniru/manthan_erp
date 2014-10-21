class DefaultMaster < ActiveRecord::Base
  belongs_to :admission
  scope :get_form_no, lambda{where("default_name = 'form_no'")}

end
