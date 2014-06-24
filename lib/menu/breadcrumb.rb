class Breadcrumb < Struct.new(:breadcrumbs, :request)
  
  def push_element
    key = get_key
    if !json_request? and request.get? and !sessions_controller?
      unless exists?(key)
        breadcrumbs.push(BreadcrumbElement.new(:name => key, :url => get_url))
      end  
    end
    change_class(key)
  end
  
  def json_request?
    request.format.symbol == :json
  end
  
  def sessions_controller?
    request.params[:controller] == "sessions"
  end
  
  def get_key
    cntrl = request.params[:controller]
    action = request.params[:action]
    unless action == "index"
      "#{action.titleize} #{cntrl.titleize}"
    else
      "#{cntrl.titleize}"
    end
  end

  def get_url
    request.original_fullpath
  end

  def exists?(key)
    breadcrumbs.select do|breadcrumb|
      breadcrumb.name == key
    end.length > 0  
  end

  def change_class(key)
    breadcrumbs.each do|breadcrumb|
      if breadcrumb.name == key
        breadcrumb.klass = "active"
      else
        breadcrumb.klass = ""
      end
    end
  end

  private
  class BreadcrumbElement
    include Virtus.model
    attribute :name, :String
    attribute :url, :String
    attribute :klass, :String
  end

  def new_list
    @breadcrumbs = []
  end

end
