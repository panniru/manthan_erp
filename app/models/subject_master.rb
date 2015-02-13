class SubjectMaster < ActiveRecord::Base
  validates :subject_name, :uniqueness => {:case_sensitive => false}

  def self.get_sub_name(sub_exists,sub_id)
    if sub_exists == false
      nil # explicit nil
    else
      SubjectMaster.find(sub_id).subject_name 
    end
  end
end
