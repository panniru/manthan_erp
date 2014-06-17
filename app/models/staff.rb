class Staff < ActiveRecord::Base
  scope :search, lambda { |id| where(:id => id)}
  def self.search(search)
    if search
     find(:all,:conditions => ['grade LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
