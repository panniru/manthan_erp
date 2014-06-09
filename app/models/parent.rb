class Parent < ActiveRecord::Base
  has_many :students, :class_name => "StudentHr"
  belongs_to :user
end
