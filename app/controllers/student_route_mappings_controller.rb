class StudentRouteMappingsController < ApplicationController
  def index
    @student_route_mappings = StudentRouteMapping.all
    
  end

  def create
  end
  
  def get_location_view
    var = LocationMaster.all.map do |var|
      {location_name: var.location_name,id: var.id}
    end
    render :json => var
  end
  
  def show
  end
end
