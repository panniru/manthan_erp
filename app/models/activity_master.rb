class ActivityMaster < ActiveRecord::Base
  validates :activity_name, :uniqueness => {:case_sensitive => false}
end
