class Event < ActiveRecord::Base
  attr_accessor :admission, :admission_id
  belongs_to :admission
  belongs_to :teacher_leader,:foreign_key => 'teacher_leader_id'
end
