class MainMenu < ActiveRecord::Base
  has_many :sub_menus
  has_one :role_menu_priority
  has_many :sub_menu_role_mappings

  def self.prioritized_main_menu_for_role(role)
    MainMenu.select("main_menus.id, main_menus.main_menu_name, role_menu_priorities.priority, role_menu_priorities.role_id").joins("LEFT OUTER JOIN role_menu_priorities ON role_menu_priorities.role_id = #{role.id} AND role_menu_priorities.main_menu_id = main_menus.id").order("role_menu_priorities.priority")
  end
end
