class Grade < ActiveRecord::Base
	has_many :sections
	has_many :subjects
	accepts_nested_attributes_for :subjects
end
