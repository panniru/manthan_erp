class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :store_location
  before_action :authenticate_user!
  before_filter :update_breadcrumb
  
  
  after_filter :set_csrf_cookie_for_ng

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    text_or_html_request do
      session[:previous_url] = request.fullpath 
    end
      

  end
  def text_or_html_request
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr? &&
        request.format == "text/html" || 
        request.content_type == "text/html") # don't store ajax calls
      yield 
    end
  end
  
  def track_menus
    text_or_html_request do
      track_main_menu(params)
      track_sub_menu(params)
    end
  end
  
  def after_sign_in_path_for(resource)
    if current_user.present? and session[:user_main_menu].nil?
      session[:user_main_menu] = RoleMenuMapper.new(current_user.role).user_main_menu || []
    end
    if session[:active_main_menu_id].nil?
      session[:active_main_menu_id] = session[:user_main_menu].first.try(:id)
      session[:active_sub_menu_id] = nil
    end
    root_path = session[:user_main_menu].first.try(:url)
    session[:previous_url] || root_path.nil? ? "/home" : root_path
  end

  def render *args
    track_menus
    super
  end
  protected


  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def update_breadcrumb
    @breadcrumbs = session[:breadcrumbs]
    @breadcrumbs = [] unless @breadcrumbs.present?
    Breadcrumb.new(@breadcrumbs, request).push_element
    session[:breadcrumbs] = @breadcrumbs
  end

  def track_main_menu(params)
    if params[:m_m_id].present?
      session[:active_main_menu_id] = params[:m_m_id]
    end
  end
  
  def track_sub_menu(params)
    if params[:s_m_id].present?
      session[:active_sub_menu_id] = params[:s_m_id]
    end
  end
end
