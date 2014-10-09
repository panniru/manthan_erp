class FacultyMastersController < ApplicationController
  load_resource :only => [:dashboard]
  authorize_resource
  
  def dashboard
  end
end
