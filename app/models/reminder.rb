class Reminder < ActiveRecord::Base
  validates :description, :presence => true
  validates :created_date, :presence => true


  def active?(date)
    last_change_date = previous_resolution_date.present? ? previous_resolution_date : created_date
    if monthly?
      last_change_date.month != date.month and last_change_date.year != date.year
    elsif quarterly?
      (date.year * 12 + date.month) - (last_change_date.year * 12 + last_change_date.month) >= 4
    elsif yearly?
      ((date.year * 12 + date.month) - (last_change_date.year * 12 + last_change_date.month))/12 >= 1
    end
  end

  def due_date
    created_date.next_month
  end

  def monthly?
    occurrence == "monthly"
  end

  def quarterly?
    occurrence == "quarterly"
  end

  def yearly?
    occurrence == "yearly"
  end

  def mark_as_done(resolution_date)
    self.update_attributes(:previous_resolution_date => resolution_date)
  end
 
end
