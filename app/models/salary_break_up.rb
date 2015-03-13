class SalaryBreakUp < ActiveRecord::Base
  validates :component, :presence => true
  validates :component_code, :presence => true
  validates :criteria, :presence => true, numericality: true

  scope :belongs_to_salary, lambda {where("break_up_type = 'salary' or break_up_type IS NULL")}
  scope :belongs_to_pf, lambda {where(:break_up_type => 'pf')}
  scope :belongs_to_default, lambda {where(:break_up_type => 'default')}
  
  def component_value
    if component_code =~ /month/
      Date::MONTHNAMES[criteria]
    else
      p "11111"
      criteria
    end
  end
  
  def component_description
    "#{Payroll::SalaryBreakUpCreator::BREAK_UP_FORUMULA_DESC[component_code.to_sym]}"
  end
end
