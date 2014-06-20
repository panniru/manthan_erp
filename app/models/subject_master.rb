class SubjectMaster < ActiveRecord::Base
  def self.get_sub_name(sub_id)
    if sub_id == false
      nil
    else
      subject = SubjectMaster.find(sub_id).subject # explicit nil so other developers know exactly what's going on
    end
  end
end
