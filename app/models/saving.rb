class Saving < ActiveRecord::Base
  belongs_to :faculty_master
  belongs_to :salary_tax
end
