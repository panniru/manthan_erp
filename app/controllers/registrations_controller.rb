class RegistrationsController < Devise::RegistrationsController
  
  def edit
    p "111111111111111"
    p params[:format]
    if params[:format].present?
      @resource = User.find(params[:format])
    else
      @resource = User.find(current_user.id)
    end
    super
  end

  def update
    user = User.find(params[:user][:id])
    @user.id = user.id
    super
  end
  
   protected

  def after_update_path_for(resource)
    p " resource.user_id"
    p resource.user_id
    p "current_user.user_id"
    p current_user.user_id
    if current_user.user_id == resource.user_id
      home_index_path
    else
      edit_user_home_index_path
    end
  end

end
