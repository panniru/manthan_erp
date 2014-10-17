class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :update_breadcrumb
  
  
  after_filter :set_csrf_cookie_for_ng

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
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
    gon.academicYearFrom = "2013"
    gon.academicYearTo = "2014"
  end

end
