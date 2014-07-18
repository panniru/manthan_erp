module AdmissionsHelper
  def is_active?(page_name)
    "active" if params[:status] == page_name
  end
  
end
