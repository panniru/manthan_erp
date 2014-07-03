class Admission < ActiveRecord::Base

  scope :enquiry_forms_or_application_forms, lambda{where("status = 'Enquiry Created' or status = 'Application Created'")}
  scope :closed_forms, lambda{where("status = 'Form Closed'")}
  scope :enquiry_forms,lambda{where("status = 'Enquiry Created'")}
  scope :application_forms,lambda{where("status = 'Application Created'")}
  def self.search(search)
    return scoped unless search.present?
    where(['admission_no LIKE ? OR form_no LIKE ? OR name LIKE ? OR klass LIKE ?  OR father_name LIKE ? OR father_mobile LIKE ?  ', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  end
end
