class Recruitment < ActiveRecord::Base
  LANGUAGES = [["English"], ["Tamil"], ["Hindi"],["Telugu"],["Malayalam"],["Urdu"],["Punjabi"],["Bengali"],["French"],["Chinese"]]
  scope :application_forms, lambda{where("status = 'Application_Created' or status = 'Assessment_Planned'or status = 'Assessment_Completed'")}
  scope :search, lambda {|id| where(:id => id)}
  def self.search(search)
    if search 
      find(:all, :conditions => ['status LIKE ? ', "%#{search}%"])
    else
      find(:all)
    end
  end

end
