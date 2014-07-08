class Event < ActiveRecord::Base
  attr_accessor :admission, :admission_id
  has_many :admissions
  
end
