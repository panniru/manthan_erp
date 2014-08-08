class HrmSubMenu
  
  def initialize(args)
    @controller = args[:controller]
    @params = args[:params]
  end
  
  def admin_sub_menu
    p "============="
    p @params
    
    if @params[:action].present? and @params[:action] != 'index'
      return student_masters_sub_menu
    else
      sub_menu = []
      sub_menu << students
      sub_menu << parents
      sub_menu << teachers
      sub_menu << accounting
      sub_menu << vendor
      sub_menu << travelling
      return sub_menu
    end
    
  end

  private

  def student_masters_sub_menu
    sub_menu = []
    sub_menu << student
    sub_menu << academics 
  end

  def academics
    MenuItem.new(:label => "Academics", :klass => "dashboard ", :icon => "dashboard ", :href => "/student_masters/"+@params[:id]+"/dashboard?context=HRM")
  end

  def student
    MenuItem.new(:label => "#{StudentMaster.find(@params[:id]).name}", :klass => "", :icon => "female ", :href => "/student_masters/"+@params[:id]+"?context=HRM")
  end

  def students
    MenuItem.new(:label => "Students", :klass => "", :icon => "female ", :href => "/student_masters?context=HRM")
  end

  def parents
    MenuItem.new(:label => "Parent", :klass => "", :icon => "user ", :href => "/parents?context=HRM")
  end

  def teachers
    MenuItem.new(:label => "Teachers", :klass => "", :icon => "users ", :href => "#")
  end
  
  def accounting
    MenuItem.new(:label => "Accounting", :klass => "", :icon => "table ", :href => "#")
  end  
  def vendor
    MenuItem.new(:label => "Vendor", :klass => "", :icon => " ", :href => "#")
  end
  
  def travelling
    MenuItem.new(:label => "Travelling", :klass => "", :icon => "automobile ", :href => "#")
  end      
end
