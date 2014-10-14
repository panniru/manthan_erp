class RoleMenuMappingsController < ApplicationController
  
  def roles
    respond_to do |format|
      format.json do 
        render :json => Role.all
      end
    end
  end

  def list_mapping
    respond_to do |format|
      format.json do 
        render :json => RoleMenuMapper.new(Role.find(params[:role_id])).get_role_mapping
      end
    end
  end

  def save_mapping
    respond_to do |format|
      format.json do 
        render :json => RoleMenuMappingCreator.new(Role.find(params[:role_id]), ActionController::Parameters.new(params).require(:mapping)).save
      end
    end
  end
end
