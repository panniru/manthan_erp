class Parent < ActiveRecord::Base
  has_many :students, :class_name => "StudentMaster"
  belongs_to :user
end
