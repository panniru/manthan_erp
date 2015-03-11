class DayEnd < ActiveRecord::Base
  class << self
    def current_date
      if self.first.present?
        self.first.transaction_date + 1
      else
        Date.today
      end
    end
  end
end
