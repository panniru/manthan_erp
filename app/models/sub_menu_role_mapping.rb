class SubMenuRoleMapping < ActiveRecord::Base
  validates :role_id, :presence => true
  validates :sub_menu_id, :presence => true
  belongs_to :sub_menu
  belongs_to :role
  scope :belongs_to_role, lambda{|role| where(:role_id => role)}
end
