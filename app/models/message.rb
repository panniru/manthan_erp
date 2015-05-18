class Message < ActiveRecord::Base
  #validates :subject, :presence => true
  #attr_accessible :content, :subject
  include PgSearch
  multisearchable :against => [:content , :subject]
  validates :content, :presence => true
   
  has_many :communication_mails
end
