class UserMenu
  
  def initialize(user, context)
    @user = user
    @context = context
  end

  def sub_menu
    if @user.admin?
      @context.admin_sub_menu
    elsif @user.parent?
      @context.parent_sub_menu
    elsif @user.accountant?
      @context.accountant_sub_menu
    end
  end
  def admission_sub_menu
    if @user.admin?
      @context.admin_sub_menu
    elsif @user.parent?
      @context.parent_sub_menu
    elsif @user.accountant?
      @context.accountant_sub_menu
    end
  end
end
