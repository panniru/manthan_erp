class Admission < ActiveRecord::Base
  
  scope :enquiry_forms_or_application_forms, lambda{where("status = 'Enquiry_Created' or status = 'Application_Created'")}
  scope :closed_forms, lambda{where("status = 'Form_Closed'")}
  scope :enquiry_forms,lambda{where("status = 'Enquiry_Created'")}
  scope :application_forms,lambda{where("status = 'Application_Created'")}
  scope :search, lambda {|id| where(:id => id)}
  def self.search(search)
    if search 
      find(:all, :conditions => ['status LIKE ? ', "%#{search}%"])
    else
      find(:all)
    end
  end
end
