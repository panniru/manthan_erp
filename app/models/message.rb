class Message < ActiveRecord::Base
  #validates :subject, :presence => true
  validates :content, :presence => true
  
  has_many :cummunication_mails
end
