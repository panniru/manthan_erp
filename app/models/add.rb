class Add < ActiveRecord::Base
  validates :title, :presence => true
  validates :date, :presence => true
  validates :description, :presence => true
end

