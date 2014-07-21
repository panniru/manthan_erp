class Issuing < ActiveRecord::Base
  acts_as_paranoid
  attr_accessor :is_returned
  
  belongs_to :student, :class_name => "StudentMaster"
  # validates :name, :presence => true
  # validates :section, :presence => true
  # validates :grade, :presence => true
 
end
