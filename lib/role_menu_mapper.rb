class RoleMenuMapper

  def initialize(role)
    @role = role
  end
  
  def get_role_mapping
    MainMenu.prioritized_main_menu_for_role(@role).map do |menu|
      sub_menus = menu.sub_menus.sub_menu_including_role(@role).map do |sub_menu|
        {:sub_menu_id => sub_menu.id, :sub_menu_name => sub_menu.sub_menu_name.titleize, :is_assigned => sub_menu.role_id.present?}
      end

      {
        :main_menu_id => menu.id,
        :main_menu_name => menu.main_menu_name.titleize,
        :priority => menu.priority,
        :is_assigned => menu.role_id.present?,
        :sub_menus => sub_menus
      }
    end
  end

  def user_main_menu
    RoleMenuPriority.belongs_to_role(@role).order("priority").map do |menu|
      OpenStruct.new(menu.main_menu.attributes)
    end
  end

  def user_sub_menu(main_menu_id)
    p "main_menu============================="
    p main_menu_id
    #if main_menu.sub_menu_role_mappings.present?
      MainMenu.find(main_menu_id).sub_menu_role_mappings.belongs_to_role(@role).map(&:sub_menu) 
    #else
    #  []
   # end
  end
  
end
