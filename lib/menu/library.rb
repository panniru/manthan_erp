class Library

  def initialize(args)
    @controller = args[:controller]
  end

  def admin_sub_menu
    sub_menu = []    
    sub_menu << books
    sub_menu << request_books_admin
   
end
  def librarian_sub_menu
    
    sub_menu = []    
    sub_menu << books
    sub_menu << issuing_books
    sub_menu << damage_books
    sub_menu << block_books
    sub_menu << request_books_admin
    sub_menu << donate_books
    sub_menu << reports
  end
  def parent_sub_menu
    sub_menu = []
    sub_menu << request_books
    sub_menu
  end
  def teacher_sub_menu
    sub_menu = []
    sub_menu << request_books
    sub_menu
  end
  def principal_sub_menu
    sub_menu = []
    sub_menu << approval_books    
  end

  private 

  def  books
    MenuItem.new(:label => "Books", :klass => "", :icon => "book ", :href => "/books")
  end
  def issuing_books
    MenuItem.new(:label => "Issue/Return Books", :klass => "", :icon => "cubes", :href => "/issuings")
  end
  def damage_books
    MenuItem.new(:label => "Damage/Loss Books", :klass => "", :icon => "file-excel-o ", :href => "/damagebooks")
  end
  def block_books
    MenuItem.new(:label => "Block Books", :klass => "", :icon => "file-zip-o ", :href => "/block_books")
  end
  def request_new_books
    MenuItem.new(:label => "Suggest New Book", :klass => "", :icon => "book ", :href => "/request_new_books")
  end
  def suggest_new_books
    MenuItem.new(:label => "Suggest New Book", :klass => "", :icon => "book ", :href => "/request_new_books/suggest_teacher")
  end
  def approval_for_books
    MenuItem.new(:label => "Approval For New Book", :klass => "", :icon => "check-square-o  ", :href => "/request_new_books/request_approval")
  end 
  def accepted_books
    MenuItem.new(:label => "Accepted Books", :klass => "", :icon => "level-down  ", :href => "/request_new_books/book_accept")
  end
  def rejected_books
    MenuItem.new(:label => "Rejected Books", :klass => "", :icon => "level-up", :href => "/request_new_books/book_reject")
  end
  def accepted_books
    MenuItem.new(:label => "Accepted Books", :klass => "", :icon => "level-down ", :href => "/request_new_books/book_accept")
  end
  def rejected_books
    MenuItem.new(:label => "Rejected Books", :klass => "", :icon => "level-up ", :href => "/request_new_books/book_reject")
  end
  def donate_books
    MenuItem.new(:label => "Donate Books", :klass => "", :icon => "cubes  ", :href => "/donate_books")
  end
  def reports
    MenuItem.new(:label => "Reports", :klass => "", :icon => "file-image-o  ", :href => "/lib_reports")
  end

  def request_books
    MenuItem.new(:label => "Suggest New Book", :klass => "", :icon => "book ", :href => "/request_books")
  end

  def approval_books
    MenuItem.new(:label => "Approval For New Book", :klass => "", :icon => "check-square-o ", :href => "/request_books")
  end  

  def request_books_admin
    MenuItem.new(:label => "Request Books", :klass => "", :icon => "book ", :href => "/request_books")
  end
end
