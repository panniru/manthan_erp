class Job < ActiveRecord::Base
  scope :matching_code, lambda {|code| where(:code => code)}
end
