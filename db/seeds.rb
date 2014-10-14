# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl_rails'


def seed_role
  @admin = Role.find_by_code("admin")
  @parent = Role.find_by_code("parent")
  @accountant = Role.find_by_code("accountant")
  @principal = Role.find_by_code("principal")
  @bod = Role.find_by_code("bod")
  @teacher = Role.find_by_code("teacher")
  @librarian = Role.find_by_code("librarian") 
  @transport_head = Role.find_by_code("transport_head")
  @canteenmanager = Role.find_by_code("canteenmanager")

  unless @admin.present?
    Role.create(:role => "admin", :code => "admin", :description => "admin")
  end

  unless @parent.present?
    Role.create(:role => "parent", :code => "parent", :description => "parent")
  end

  unless @accountant.present?
    Role.create(:role => "accountant", :code => "accountant", :description => "accountant")
  end
  
  unless @principal.present?
    Role.create(:role => "principal", :code => "principal", :description => "principal")
  end
  
  unless @bod.present?
    Role.create(:role => "bod", :code => "bod", :description => "bod")
  end
  unless @teacher.present?
    Role.create(:role => "teacher", :code => "teacher", :description => "teacher")
  end
  unless @librarian.present?
    Role.create(:role => "librarian", :code => "librarian", :description => "librarian")
  end
  unless @transport_head.present?
    Role.create(:role => "transport_head",:code => "transport_head",:description => "transport_head")
  end

  unless @canteenmanager.present?
    Role.create(:role => "canteenmanager", :code => "canteenmanager", :description => "canteenmanager")
  end
end


def seed_user
  admin_role = Role.find_by_code("admin")
  parent_role = Role.find_by_code("parent")
  accountant_role = Role.find_by_code("accountant")
  principal = Role.find_by_code("principal")
  bod = Role.find_by_code("bod")
  teacher = Role.find_by_code("teacher")
  librarian = Role.find_by_code("librarian")
  transport_head = Role.find_by_code("transport_head")
  canteenmanager = Role.find_by_code("canteenmanager")


  @user_admin = User.find_by_role_id(admin_role)
  @user_parent = User.find_by_role_id(parent_role)
  @user_accountant = User.find_by_role_id(accountant_role)
  @user_principal = User.find_by_role_id(principal)
  @user_bod = User.find_by_role_id(bod)
  @user_teacher = User.find_by_role_id(teacher)
  @user_librarian = User.find_by_role_id(librarian)
  @user_teacher = User.find_by_user_id('teacher1')
  @user_transport_head = User.find_by_role_id(transport_head)
  @user_canteenmanager = User.find_by_role_id(canteenmanager)

  unless @user_principal.present?
    User.create(:email => "principal@manthan.com", :password => "welcome", :user_id => "principal", :role_id => principal.id)
  end
  
  unless @user_bod.present?
    User.create(:email => "bod@manthan.com", :password => "welcome", :user_id => "bod", :role_id => bod.id)
  end
  
  
  unless @user_admin.present?
    User.create(:email => "admin@manthan.com", :password => "welcome", :user_id => "admin", :role_id => admin_role.id)
  end

  unless @user_parent.present?
    User.create(:email => "parent@manthan.com", :password => "welcome", :user_id => "parent", :role_id => parent_role.id)
  end

  unless @user_accountant.present?
    User.create(:email => "accountant@manthan.com", :password => "welcome", :user_id => "accountant", :role_id => accountant_role.id)
  end
  unless @user_teacher.present?
    User.create(:email => "teacher@manthan.com", :password => "welcome", :user_id => "teacher", :role_id => teacher.id)
  end
  unless @user_librarian.present?
    User.create(:email => "librarian@manthan.com", :password => "welcome", :user_id => "librarian", :role_id => librarian.id)
  end
  unless @user_teacher.present?
    User.create(:email => "swamy@manthan.com", :password => "welcome", :user_id => "teacher1", :role_id => teacher.id)
  end

  unless @user_transport_head.present?
    User.create(:email => "transport_head@manthan.com", :password => "welcome", :user_id => "transport_head", :role_id => transport_head.id)
  end

  unless @user_canteenmanager.present?
    User.create(:email => "canteenmanager@manthan.com", :password => "welcome", :user_id => "canteenmanager", :role_id => canteenmanager.id)
  end
end


def seed_jobs
  job_attributes = FactoryGirl.attributes_for(:fee_structure_mailing)
  Job.where(code: job_attributes[:code]).first_or_create!(job_attributes.delete_if { |k,v| k == :code })
  job_attributes = FactoryGirl.attributes_for(:route_mailing)
  Job.where(code: job_attributes[:code]).create(job_attributes.delete_if { |k,v| k == :code })
  job_attributes = FactoryGirl.attributes_for(:special_route_mailing)
  Job.where(code: job_attributes[:code]).create(job_attributes.delete_if { |k,v| k == :code })
  
end

def seed_payment_types
  PaymentType.where(code: "annual").first_or_create!(:code => "annual")
  PaymentType.where(code: "term_wise").first_or_create!(:code => "term_wise")
  PaymentType.where(code: "monthly").first_or_create!(:code => "monthly")
end

def seed_grades
  unless GradeMaster.first.present?
    GradeMaster.create(:grade_name => 'PP1')
    GradeMaster.create(:grade_name => 'PP2')
    GradeMaster.create(:grade_name => '1')
    GradeMaster.create(:grade_name => '2')
    GradeMaster.create(:grade_name => '3')
    GradeMaster.create(:grade_name => '4')
    GradeMaster.create(:grade_name => '5')
    GradeMaster.create(:grade_name => '6')
    GradeMaster.create(:grade_name => '7')
    GradeMaster.create(:grade_name => '8')
    GradeMaster.create(:grade_name => '9')
    GradeMaster.create(:grade_name => '10')  
  end
end


def seed_parents
  Parent.first_or_create(:father_name => "Raghu", :mother_name => "Janaki", :father_email => "navya@ostryalabs.com", :mother_email => "navya@ostryalabs.com", :user_id => User.find_by_role_id(Role.find_by_code("parent")).id)
  Parent.create(:father_name => "Ramu", :mother_name => "Jani", :father_email => "shanmugapriya@ostryalabs.com", :mother_email => "navya@ostryalabs.com", :user_id => User.find_by_role_id(Role.find_by_code("parent")).id)
  Parent.create(:father_name => "Raju", :mother_name => "Janu", :father_email => "umarani@ostryalabs.com", :mother_email => "navya@ostryalabs.com", :user_id => User.find_by_role_id(Role.find_by_code("parent")).id)
end

def seed_students
  student = StudentMaster.first
  unless student.present?
    StudentMaster.create(:name => "Sankl", :dob => "17-06-1989", :joining_date => DateTime.now, :parent_master_id => Parent.first.id, :grade_master_id => GradeMaster.first.id, :bus_facility => true, :section_master_id => '1')

    StudentMaster.create(:name => "Srikanth", :dob => "17-06-1989", :joining_date => DateTime.now, :parent_master_id => Parent.first.id, :grade_master_id => GradeMaster.last.id, :bus_facility => true ,:section_master_id => '1')
    StudentMaster.create(:name => "Sankl", :dob => "17-06-1989", :joining_date => DateTime.now, :grade_master_id => GradeMaster.first.id, :bus_facility => true, :section_master_id => '1')
    StudentMaster.create(:name => "Gopika", :grade_master_id => "1",:bus_facility => true, :section_master_id => '2')
    StudentMaster.create(:name => "Priya", :grade_master_id => "1",:bus_facility => true, :section_master_id => '2')
    StudentMaster.create(:name => "Navya", :grade_master_id => "1",:bus_facility => true, :section_master_id => '3')
    StudentMaster.create(:name => "Muralee", :grade_master_id => "1",:bus_facility => true, :section_master_id => '1')

  end
end



def seed_location_masters
  unless LocationMaster.first.present?
    LocationMaster.create(:id => '10', :location_name =>  'Kothaguda', :latitude => ' 17.4652114 '  , :longitude => '78.37569' )
    LocationMaster.create(:id => '11', :location_name =>  'Madinaguda', :latitude => '  17.4936856'  , :longitude => '78.3401293' )
    LocationMaster.create(:id => '12', :location_name =>  'Rajahmundry', :latitude => ' 17.0005383  '  , :longitude => '81.8040345' )
    LocationMaster.create(:id => '13', :location_name =>  ' Punjagutta', :latitude => '17.4244971  '  , :longitude => ' 78.451038' )
    LocationMaster.create(:id => '14', :location_name =>  'Hyderabad', :latitude => '  17.2472528 '  , :longitude => '80.1514447 ' )
    LocationMaster.create(:id => '15', :location_name =>  'Mehadipatnam', :latitude => ' 17.3916361  '  , :longitude => '78.4400648') 
    LocationMaster.create(:id => '16', :location_name =>  'Yousufguda', :latitude => ' 17.4353328 '  , :longitude => '78.4357118 ' )
    LocationMaster.create(:id => '17', :location_name =>  'Gachibowli', :latitude => ' 17.4359437 '  , :longitude => ' 78.3416731' )
    LocationMaster.create(:id => '18', :location_name =>  ' Begumpeta ', :latitude => ' 17.4244971 '  , :longitude => ' 78.451038 ' )
    LocationMaster.create(:id => '19', :location_name =>  ' Limgampalli ', :latitude => ' 17.480000 '  , :longitude => '78.330000 ' )
    LocationMaster.create(:id => '20', :location_name => 'Jubilee hills checkpost',:latitude => '17.428604 '  , :longitude => '78.417604 ' )
    LocationMaster.create(:id => '21', :location_name =>  'Peddamma Temple,hyderabad ', :latitude => '17.430186 '  , :longitude => ' 78.405195 ' )
    LocationMaster.create(:id => '22', :location_name =>  'Madhapur Police Station, hyderabad ', :latitude => ' 17.4389913' ,:longitude => '78.3971339')
    LocationMaster.create(:id => '23', :location_name =>  'Miyapur', :latitude => '17.494793'  , :longitude => '78.399644' )
    LocationMaster.create(:id => '24', :location_name =>  'Kukatpally', :latitude => '17.494793'  , :longitude => '78.399644' )
  end
end

def seed_locations
  unless Location.first.present?
    Location.create(:id => '25' , :sequence_no => '1' , :route_id => '18', :location_master_id => '22'  )
    Location.create(:id => '26' , :sequence_no => '4' , :route_id => '18', :location_master_id => '19'  )
    Location.create(:id => '27' , :sequence_no => '2' , :route_id => '18', :location_master_id => '10'  )
    Location.create(:id => '28' , :sequence_no => '3' , :route_id => '18', :location_master_id => '17'  )
    Location.create(:id => '29' , :sequence_no => '3' , :route_id => '19', :location_master_id => '15'  )
    Location.create(:id => '30' , :sequence_no => '1' , :route_id => '19', :location_master_id => '13'  )
    Location.create(:id => '31' , :sequence_no => '2' , :route_id => '19', :location_master_id => '18' )
    Location.create(:id => '32' , :sequence_no => '1' , :route_id => '20', :location_master_id => '16'  )
    Location.create(:id => '33' , :sequence_no => '2' , :route_id => '20', :location_master_id => '20'  )
    Location.create(:id => '34' , :sequence_no => '3' , :route_id => '20', :location_master_id => '21' )
    Location.create(:id => '35' , :sequence_no => '4' , :route_id => '20', :location_master_id => '14'  )
    Location.create(:id => '36' , :sequence_no => '1' , :route_id => '21', :location_master_id => '11'  )
    Location.create(:id => '37' , :sequence_no => '3' , :route_id => '21', :location_master_id => '24'  )
    Location.create(:id => '38' , :sequence_no => '2' , :route_id => '21', :location_master_id => '23'  )
  
  end
end



def seed_new_vehicles
  unless NewVehicle.first.present?
  NewVehicle.create(:id => '10',:model_no => 'AT5678',:make_of_bus =>  'TOYOTA',:year_of_manufacture => '2011',:purchase_option => 'Own',:purchase_option_date => '5/6/2011',:capacity => '50' )
  NewVehicle.create(:id => '12',:model_no => 'AT5678',:make_of_bus =>  'TOYOTA',:year_of_manufacture => '2011',:purchase_option =>  'Own',:purchase_option_date => '5/6/2011',:capacity => '50' )
  NewVehicle.create(:id => '13',:model_no => 'TR879',:make_of_bus =>  'TOYOTA',:year_of_manufacture => '2000',:purchase_option =>  'Lease',:purchase_option_date => '5/6/2011',:capacity => '50' ) 
    NewVehicle.create(:id => '14',:model_no => 'VB879',:make_of_bus =>  'TOYOTA',:year_of_manufacture => '2000',:purchase_option =>  'Lease',:purchase_option_date => '5/6/2011',:capacity => '50' ) 
  end
end


def seed_student_route_mapping
  unless StudentRouteMapping.first.present?
    StudentRouteMapping.create(:id => '10' , :route_id => '18' , :student_master_id => '2',:location_master_id => '10' )
  end
end


def seed_staff_leader
  unless StaffLeader.first.present?
    StaffLeader.create(:heads => 'NAVYA-Transport')
    StaffLeader.create(:heads => 'SRIKANTH-Teaching')
    StaffLeader.create(:heads => 'MURALEE-Non-Teaching')
    StaffLeader.create(:heads => 'SWAMY-Sports')
    StaffLeader.create(:heads => 'UMA-Extra-Curricular')
  end
end
  

def seed_routes
  unless Route.first.present?
    Route.create(:id => '18' ,  :busno_up => '13' , :lpp => 'Up route', :gmaps => '' , :start_point => '25' , :end_point => '26' )
    Route.create(:id => '19' , :busno_up => '10' ,  :lpp => 'Up route' , :gmaps => '' , :start_point => '30' , :end_point => '29' )
    Route.create(:id => '20' ,  :busno_up => '12' , :lpp => 'Down route', :gmaps => '' , :start_point => '32' , :end_point => '35' )
    Route.create(:id => '21' ,  :busno_up => '14' , :lpp => 'Down route',  :gmaps => '' , :start_point => '36' , :end_point => '37' )
  
  end
end

    
def seed_subjects
  unless SubjectMaster.first.present?
    SubjectMaster.create(:subject_name => 'PHYSICS')
    SubjectMaster.create(:subject_name => 'CHEMISTRY')
    SubjectMaster.create(:subject_name => 'MATHEMATICS')
    SubjectMaster.create(:subject_name => 'ENGLISH')
    SubjectMaster.create(:subject_name => 'TELUGU')    
  end
end

def seed_defaults
  unless DefaultMaster.first.present?
    DefaultMaster.create(:default_name => 'no_of_periods',:default_value => '8')
  end
end

def seed_default_discount
  unless DefaultMaster.find_by_default_name("discount").present?
    DefaultMaster.create(:default_name => 'discount',:default_value => '15')
  end
end

def seed_default_form_no
  unless DefaultMaster.find_by_default_name("form_no").present?
    DefaultMaster.create(:default_name => 'form_no',:default_value => '1001')
  end
end
def seed_faculty
  unless FacultyMaster.first.present?
    FacultyMaster.create(:faculty_name => 'SRIKANTH')
    FacultyMaster.create(:faculty_name => 'MURALEE')
    FacultyMaster.create(:faculty_name => 'SWAMY', :user_id => User.find_by_user_id('teacher1').id)
    FacultyMaster.create(:faculty_name => 'PRIYA')
    FacultyMaster.create(:faculty_name => 'NAVYA')
    FacultyMaster.create(:faculty_name => 'UMA')
    FacultyMaster.create(:user_id => 6, :faculty_name => 'teacher')

  end
end 

def seed_tecaher_grade_mapping
  unless TeacherGradeMapping.first.present?
    grademasters=GradeMaster.all
    sectionmasters=SectionMaster.all
    subjectmasters=SubjectMaster.all
    facultymasters=FacultyMaster.all
    TeacherGradeMapping.create(:grade_master_id => grademasters[1]['id'], :section_master_id => sectionmasters[0]['id'], :subject_master_id => subjectmasters[0]['id'] , :faculty_master_id => facultymasters[0]['id'])
    TeacherGradeMapping.create(:grade_master_id => grademasters[1]['id'], :section_master_id => sectionmasters[1]['id'], :subject_master_id => subjectmasters[0]['id'] , :faculty_master_id => facultymasters[0]['id'])
    TeacherGradeMapping.create(:grade_master_id => grademasters[0]['id'], :section_master_id => sectionmasters[4]['id'], :subject_master_id => subjectmasters[0]['id'] , :faculty_master_id => facultymasters[0]['id'])
    TeacherGradeMapping.create(:grade_master_id => grademasters[2]['id'], :section_master_id => sectionmasters[3]['id'], :subject_master_id => subjectmasters[1]['id'] , :faculty_master_id => facultymasters[1]['id'])
    TeacherGradeMapping.create(:grade_master_id => grademasters[3]['id'], :section_master_id => sectionmasters[2]['id'], :subject_master_id => subjectmasters[1]['id'] , :faculty_master_id => facultymasters[1]['id'])
  end 
end


def seed_class_teacher_mapping
  unless ClassTeacherMapping.first.present?
    ClassTeacherMapping.create(:grade_master_id => '1',:section_master_id => '1',:faculty_master_id => '7')
  end
end

def seed_special_day_transport
  unless SpecialDayTransport.first.present?
    SpecialDayTransport.create(:id => '20' ,  :location_master_id => '22' , :route_id => '18', :new_up_route => '20 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '20', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:00 AM' ,  :time_down => '06:00 PM' )
    SpecialDayTransport.create(:id => '21' ,  :location_master_id => '19' , :route_id => '18', :new_up_route => '20 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '20', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:10 AM' ,  :time_down => '06:10 PM' )
    SpecialDayTransport.create(:id => '22' ,  :location_master_id => '10' , :route_id => '18', :new_up_route => '20 ' ,:occation => 'Teachers day 2014', :date => '05/09/2014',:new_down_route => '20', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:15 AM' ,  :time_down => '06:15 PM' )
    SpecialDayTransport.create(:id => '23' ,  :location_master_id => '17' , :route_id => '18', :new_up_route => '20 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '20', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:20 AM' ,  :time_down => '06:20 PM' )
    SpecialDayTransport.create(:id => '24' ,  :location_master_id => '15' , :route_id => '19', :new_up_route => '21 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '21', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:00 AM' ,  :time_down => '06:00 PM' )
    SpecialDayTransport.create(:id => '25' ,  :location_master_id => '13' , :route_id => '19', :new_up_route => '21 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '21', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:10 AM' ,  :time_down => '06:10 PM' )
    SpecialDayTransport.create(:id => '26' ,  :location_master_id => '18' , :route_id => '19', :new_up_route => '21 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '22', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:15 AM' ,  :time_down => '06:15 PM' )
    SpecialDayTransport.create(:id => '27' ,  :location_master_id => '16' , :route_id => '20', :new_up_route => '22 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '22', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:00 AM' ,  :time_down => '06:00 PM' )
    SpecialDayTransport.create(:id => '28' ,  :location_master_id => '20' , :route_id => '20', :new_up_route => '22 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '22', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:10 AM' ,  :time_down => '06:10 PM' )
    SpecialDayTransport.create(:id => '29' ,  :location_master_id => '21' , :route_id => '20', :new_up_route => '22 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '22', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:15 AM' ,  :time_down => '06:15 PM' )
    SpecialDayTransport.create(:id => '30' ,  :location_master_id => '14' , :route_id => '20', :new_up_route => '22 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '23', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:20 AM' ,  :time_down => '06:20 PM' )
    SpecialDayTransport.create(:id => '31' ,  :location_master_id => '11' , :route_id => '21', :new_up_route => '23 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '23', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:00 AM' ,  :time_down => '06:00 PM' )
    SpecialDayTransport.create(:id => '32' ,  :location_master_id => '24' , :route_id => '21', :new_up_route => '23 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '23', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:10 AM' ,  :time_down => '06:10 PM' )
    SpecialDayTransport.create(:id => '33' ,  :location_master_id => '23' , :route_id => '21', :new_up_route => '23 ',:occation => 'Teachers day 2014', :date => '05/09/2014', :new_down_route => '23', :new_busno_up => '13',:new_busno_down => '13', :time_up => '08:15 AM' ,  :time_down => '06:15 PM' )
  end
end

def seed_sections
  unless SectionMaster.first.present?
    SectionMaster.create(:section_name => 'A')
    SectionMaster.create(:section_name => 'B')
    SectionMaster.create(:section_name => 'C')
    SectionMaster.create(:section_name => 'D')
    SectionMaster.create(:section_name => 'E')
    SectionMaster.create(:section_name => 'F')
    SectionMaster.create(:section_name => 'G')
    SectionMaster.create(:section_name => 'H')
    SectionMaster.create(:section_name => 'I')
    SectionMaster.create(:section_name => 'J')
    SectionMaster.create(:section_name => 'K')
    SectionMaster.create(:section_name => 'L')  
  end
end

def seed_gradings
  unless GradingMaster.first.present?
    GradingMaster.create(:grading_name => 'A+', :grading_desc => 'Outstanding')
    GradingMaster.create(:grading_name => 'A', :grading_desc => 'Excellent')
    GradingMaster.create(:grading_name => 'B', :grading_desc => 'Very Good')
    GradingMaster.create(:grading_name => 'B-', :grading_desc => 'Good')
    GradingMaster.create(:grading_name => 'C', :grading_desc => 'Pass')
    GradingMaster.create(:grading_name => 'F', :grading_desc => 'Fail')
    GradingMaster.create(:grading_name => 'NA', :grading_desc => 'Not Appeared')
  end
end
def seed_admissions
   admission = Admission.first
   unless admission.present?
     Admission.create( :name => "ShanmugaPriya", :grade => "1", :dob => "14-12-2009", :gender => "Female", :nationality => "IN", :language => "Tamil", :father_name => "Kamaraj", :mother_name => "Selvi", :father_occupation => "Business", :mother_occupation => "Home Maker", :father_company => "Selvi Note Books", :mother_company => "Nil", :father_education => "Graduate", :mother_education => "Graduate", :income => "Rs.20,000 to Rs.50,000 p.m.",:address => "10/45, Nadar Vidhya Salai Street, Southgate,Madurai,TN", :landline => "04522333495", :mobile => "9443591500", :father_email => "shanmugapriya@ostryalabs.com", :transport => "School", :busstop => "Nil", :last_school => "St.Joseph Higher Secondary School", :city => "Madurai", :changing_reason => "Transfer", :know_school => "Friends", :person => "Kavya", :pp => "6", :status => "Enquiry_Created", :form_no => "123",:grade_master_id => GradeMaster.first.id, :teacher_leader_id => "3")
     Admission.create( :name => "Priya", :grade => "1", :dob => "14-12-2009", :gender => "Female", :nationality => "IN", :language => "Tamil", :father_name => "Kamaraj", :mother_name => "Selvi", :father_occupation => "Business", :mother_occupation => "Home Maker", :father_company => "Selvi Note Books", :mother_company => "Nil", :father_education => "Graduate", :mother_education => "Graduate", :income => "Rs.20,000 to Rs.50,000 p.m.",:address => "10/45, Nadar Vidhya Salai Street, Southgate,Madurai,TN", :landline => "04522333495", :mobile => "9443591500", :father_email => "shanmugapriya@ostryalabs.com", :transport => "School", :busstop => "Nil", :last_school => "St.Joseph Higher Secondary School", :city => "Madurai", :changing_reason => "Transfer", :know_school => "Friends", :person => "Kavya", :pp => "6", :status => "Enquiry_Created", :form_no => "124",:grade_master_id => GradeMaster.first.id, :teacher_leader_id => "3")
     Admission.create(:admission_no => "12346", :branch => "Madhapur", :surname => "Ramesh", :second_lang => "ENGLISH", :board => "CBSE", :grade => "7", :medium => "ENGLISH", :year => "2013", :written => "Good", :reading => "Good", :spoken => "Good", :blood_group => "A+", :allergy => "nil", :doctor_name => "Dr.Bose", :doctor_mobile => "04522333496", :guardian_name => "Kamaraj", :guardian_mobile => "9443591501",:guardian_relationship => "Uncle", :from => "2014", :middle_name => "R", :name => "Vibhu", :dob => "17-05-2002", :gender => "Male", :nationality => "IN", :language => "Tamil", :father_name => "Ramesh", :mother_name => "Lakshmi", :father_occupation => "Business", :mother_occupation => "I.R.A.S", :father_company => "SEVA TRADERS", :mother_company => "Indian Railway Accounts Service", :father_education => "PG", :mother_education => "PG", :income => "Rs.50,000 to Rs.1,00,000 p.m.",:address => "111E,RostRover Garden,Railway Quarters,Teynampet,Chennai", :landline => "0402333333", :mobile => "9894723978", :email => "contact@sevatraders.com", :transport => "School", :busstop => "Nil", :last_school => "Chettinad Vidyashram School", :city => "Chennai", :changing_reason => "Transfer", :know_school => "Parents whose children are studying here", :person => "Ananth", :pp => "3", :status => "Management_Reviewed", :father_office_address => "Adayar", :mother_office_address => "Egmore", :father_office_telephone => "04522333334", :father_mobile => "9894723978", :mother_mobile => "9894723979", :mother_religion => "Hindu", :father_religion => "Hindu", :father_employer => "Seva Traders", :mother_employer => "Indian Railway Accounts Service", :father_email => "navya@ostryalabs.com" , :mother_email => "lakshmi@iras.in", :sib_name1 => "Sugi", :sib_sex1 => "Female", :sib_grade1 => "6", :sib_school1 => "St.Joseph Higher Secondary School", :form_no => "1278",:grade_master_id => GradeMaster.last.id, :teacher_leader_id => "9", :faculty => "ARUN")
  Admission.create(:admission_no => "12346", :branch => "Madhapur", :surname => "Ramesh", :second_lang => "ENGLISH", :board => "CBSE", :grade => "7", :medium => "ENGLISH", :year => "2013", :written => "Good", :reading => "Good", :spoken => "Good", :blood_group => "A+", :allergy => "nil", :doctor_name => "Dr.Bose", :doctor_mobile => "04522333496", :guardian_name => "Kamaraj", :guardian_mobile => "9443591501",:guardian_relationship => "Uncle", :from => "2014", :middle_name => "R", :name => "Vibhu", :dob => "17-05-2002", :gender => "Male", :nationality => "IN", :language => "Tamil", :father_name => "Ramesh", :mother_name => "Lakshmi", :father_occupation => "Business", :mother_occupation => "I.R.A.S", :father_company => "SEVA TRADERS", :mother_company => "Indian Railway Accounts Service", :father_education => "PG", :mother_education => "PG", :income => "Rs.50,000 to Rs.1,00,000 p.m.",:address => "111E,RostRover Garden,Railway Quarters,Teynampet,Chennai", :landline => "0402333333", :mobile => "9894723978", :email => "contact@sevatraders.com", :transport => "School", :busstop => "Nil", :last_school => "Chettinad Vidyashram School", :city => "Chennai", :changing_reason => "Transfer", :know_school => "Parents whose children are studying here", :person => "Ananth", :pp => "3", :status => "Management_Reviewed", :father_office_address => "Adayar", :mother_office_address => "Egmore", :father_office_telephone => "04522333334", :father_mobile => "9894723978", :mother_mobile => "9894723979", :mother_religion => "Hindu", :father_religion => "Hindu", :father_employer => "Seva Traders", :mother_employer => "Indian Railway Accounts Service", :father_email => "navya@ostryalabs.com" , :mother_email => "lakshmi@iras.in", :sib_name1 => "Sugi", :sib_sex1 => "Female", :sib_grade1 => "6", :sib_school1 => "St.Joseph Higher Secondary School", :form_no => "1245",:grade_master_id => GradeMaster.last.id, :teacher_leader_id => "9", :faculty => "ARUN")
  
  end
 end
  
def seed_teacher_leader
  unless TeacherLeader.first.present?
    TeacherLeader.create(:klass => 'PP1',:faculty_leader => 'SRIKANTH')
    TeacherLeader.create(:klass => 'PP2',:faculty_leader => 'MURALEE')
    TeacherLeader.create(:klass => '1',:faculty_leader => 'SWAMY', :faculty_master_id => '7', :grade_master_id => '1')
    TeacherLeader.create(:klass => '2',:faculty_leader => 'PRIYA')
    TeacherLeader.create(:klass => '3',:faculty_leader => 'NAVYA')
    TeacherLeader.create(:klass => '4',:faculty_leader => 'UMA')
    TeacherLeader.create(:klass => '5',:faculty_leader => 'ANU')
    TeacherLeader.create(:klass => '6',:faculty_leader => 'VIBHU')
    TeacherLeader.create(:klass => '7',:faculty_leader => 'SUGI')
    TeacherLeader.create(:klass => '8',:faculty_leader => 'GOPIKA')
    TeacherLeader.create(:klass => '9',:faculty_leader => 'ARUN')
    TeacherLeader.create(:klass => '10',:faculty_leader => 'HARI')
    TeacherLeader.create(:klass => '11',:faculty_leader => 'SREYA')
    TeacherLeader.create(:klass => '12',:faculty_leader => 'ANANTH')
    
  end
end
def seed_attendances
  unless Attendance.first.present?
    Attendance.create(:student_master_id => '1',:attendance => 'P', :attendance_date => '2014-10-14')
    Attendance.create(:student_master_id => '2',:attendance => 'A', :attendance_date => '2014-10-14')
    Attendance.create(:student_master_id => '1',:attendance => 'L', :attendance_date => '2014-10-06')
    Attendance.create(:student_master_id => '2',:attendance => 'P', :attendance_date => '2014-10-16')
  end
end
def seed_all
  seed_role
  seed_user   
  seed_jobs
  seed_payment_types
  seed_grades  
  seed_parents
  seed_students
  seed_staff_leader
  seed_subjects
  seed_defaults
  seed_default_discount
  seed_default_form_no
  seed_faculty
  seed_location_masters
  seed_routes
  seed_locations
  seed_new_vehicles
  seed_student_route_mapping
  seed_class_teacher_mapping
  seed_special_day_transport
  seed_sections
  seed_gradings
  seed_admissions
  seed_teacher_leader
  seed_attendances
end

seed_all
