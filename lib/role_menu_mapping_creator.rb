class RoleMenuMappingCreator

  def initialize(role, params)
    @role = role
    @params = params
  end
  

  def save
    ActiveRecord::Base.transaction do
      begin
        @params.each do |param|
          save_role_menu_priority(param)
          if param[:sub_menus].present?
            param[:sub_menus].each do |sub_menu|
              save_sub_menu_role_mapping(sub_menu, param[:main_menu_id])
            end
          end
        end
      rescue Excpetion => msg
        ActiveRecord::Rollback
        return false
      end
    end
  end

  private

  def role_menu_priority_params(params)
    params.permit(:main_menu_id, :priority).merge!(:role_id => @role.id)
  end

    def sub_menu_role_mapping_params(params)
    params.permit(:sub_menu_id).merge!(:role_id => @role.id)
  end
    
  def save_role_menu_priority(params)
    r_m_p = RoleMenuPriority.find_by_main_menu_id_and_role_id(params[:main_menu_id], @role.id)
    if r_m_p.present?
      if params[:is_assigned].present? and params[:is_assigned] == true
        r_m_p.update_attributes!(params.permit(:priority))
      else
        r_m_p.destroy
      end
    else
      RoleMenuPriority.create!(role_menu_priority_params(params)) if params[:is_assigned].present? and params[:is_assigned] == true
    end
  end

  def save_sub_menu_role_mapping(params, main_menu_id)
    s_m_r_m = SubMenuRoleMapping.find_by_sub_menu_id_and_role_id(params[:sub_menu_id], @role.id)
    if s_m_r_m.present? 
      if (params[:is_assigned].nil? || params[:is_assigned] == false)
        s_m_r_m.destroy
      end
    else
        SubMenuRoleMapping.create!(sub_menu_role_mapping_params(params).merge!(:main_menu_id => main_menu_id)) if params[:is_assigned].present? and params[:is_assigned] == true
    end
  end
  
end
