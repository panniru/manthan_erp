class FacultyLeave < ActiveRecord::Base
  belongs_to :faculty_master
  scope :month, lambda{|month| where(:month => month)}
  scope :year, lambda{|year| where(:year => year)}
  scope :in_the_month, lambda{|month| where("to_char(entered_date, 'Mon') = ?", month[0..2])}
  scope :in_the_year, lambda{|year| where("to_char(entered_date, 'YYYY') = ?", year)}
  scope :in_th_month_year, lambda{|date| in_the_month(date.strftime("%b")).in_the_year(date.strftime("%Y"))}

end
