class Issuing < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :student, :class_name => "StudentMaster"
  # validates :name, :presence => true
  # validates :section, :presence => true
  # validates :grade, :presence => true
 
end
