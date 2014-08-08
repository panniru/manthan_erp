class Add < ActiveRecord::Base
  validates :title, :presence => true
  validates :description, :presence => true
  belongs_to :staffadmin
end

