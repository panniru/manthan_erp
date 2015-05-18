class FoodWastage < ActiveRecord::Base
  validates :wastage, presence: true
  scope :yesterday_wastage , lambda{where(:current_date => Date.today-1)}
  scope :weekly_wastage, lambda { where(:current_date =>  (Date.today.beginning_of_week..Date.today.end_of_week)) } 
  
  
  def self.high_day
    @avg_wastage = FoodWastage.weekly_wastage
    a = []
    @avg_wastage.each do |x|
      a << x.wastage
    end
    maximum = a.max 
    return maximum
  end

  def self.avg_wastage
    @avg_wastage = FoodWastage.weekly_wastage
    a = []
    @avg_wastage.each do |x|
      a << x.wastage
    end
    avg = a.inject{|sum,x| sum + x } 
    count = a.length
    if count > 0
      mean = avg/count.try
    else
      mean = 0
    end
    return mean 

  end
  
end
