class EnquiryFormObject
  include Virtus.model
  attribute :admission, Admission
  attribute :father_name, String
  attribute :mother_name, String
  attribute :father_email, String
  attribute :mother_email, String
  attribute :mother_phone, String
  attribute :father_phone, String

  def save
    admission.create!(:father_name => self.father_name, :father_phone => self.father_phone, :father_email => self.father_email, :mother_name => self.mother_name, :mother_phone => self.mother_phone,  :mother_email => self.mother_email) 
  end
  
  def update(params={})
    admission.update(params)
  end

  def custom_methods
  end
end
