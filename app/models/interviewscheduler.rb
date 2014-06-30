class Interviewscheduler < ActiveRecord::Base
  def self.search(search)
    return scoped unless search.present?
    where(['name LIKE ?  OR description LIKE ? ', "%#{search}%", "%#{search}%"])
  end
end
