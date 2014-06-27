class SessionsController  < Devise::SessionsController

  def create
    super
    session[:academic_year] = "2013-14"
  end

end
