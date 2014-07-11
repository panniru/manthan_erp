class Library < Struct.new(:controller)


  def admin_sub_menu
    sub_menu = []
    sub_menu << home
    sub_menu << books
   
end
  def librarian_sub_menu
    
    sub_menu = []
    sub_menu << home
    sub_menu << books
    sub_menu << issuing_books
    
  end
  private 
  def home
    MenuItem.new(:label => "Home", :klass => "", :icon => "home ", :href => "books/home_index")
  end
  def  books
    MenuItem.new(:label => "Books", :klass => "", :icon => "book ", :href => "/books")
  end
  def issuing_books
    MenuItem.new(:label => "Issuing Books", :klass => "", :icon => "cubes", :href => "/issuings")
  end
end
