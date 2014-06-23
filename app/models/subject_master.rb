class SubjectMaster < ActiveRecord::Base
  def self.get_sub_name(sub_exists,sub_id)
    if sub_exists == false
      nil # explicit nil
    else
      SubjectMaster.find(sub_id).subject 
    end
  end
end
