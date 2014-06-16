class Parent < ActiveRecord::Base
  has_many :students, :class_name => "StudentMaster"
  belongs_to :user

  def parent_name
    return self.father_name if self.father_name.present?
    return self.father_name if self.mother_name.present?
    return self.guardian_name if self.mother_name.present?
  end

end
