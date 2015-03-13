class DesignationMaster < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :role
  
  scope :has_no_admin  , lambda{where(:managed_by  => nil )}
  scope :updated_at, lambda{ order(updated_at: :desc) }
  
  scope :managed_by, (lambda do |user| 
    if user.admin? 
      all
    else
      where(:managed_by => user.role_id)
    end
  end)

  
end
