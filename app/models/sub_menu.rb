class SubMenu < ActiveRecord::Base
  belongs_to :main_menu
  has_many :sub_menu_role_mappings

  def self.sub_menu_including_role(role)
    self.select("sub_menus.id, sub_menus.sub_menu_name, sub_menu_role_mappings.role_id, sub_menus.main_menu_id").joins("LEFT OUTER JOIN sub_menu_role_mappings ON sub_menu_role_mappings.role_id = #{role.id} AND sub_menu_role_mappings.sub_menu_id = sub_menus.id")
  end

end
