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
  
end


def seed_user
  admin_role = Role.find_by_code("admin")
  parent_role = Role.find_by_code("parent")
  accountant_role = Role.find_by_code("accountant")
  principal = Role.find_by_code("principal")
  bod = Role.find_by_code("bod")

  @user_admin = User.find_by_role_id(admin_role)
  @user_parent = User.find_by_role_id(parent_role)
  @user_accountant = User.find_by_role_id(accountant_role)
  @user_principal = User.find_by_role_id(principal)
  @user_bod = User.find_by_role_id(bod)

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
end


def seed_jobs
  job_attributes = FactoryGirl.attributes_for(:fee_structure_mailing)
  Job.where(code: job_attributes[:code]).first_or_create!(job_attributes.delete_if { |k,v| k == :code })
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
  end
end


def seed_parents
  Parent.first_or_create(:father_name => "Raghu", :mother_name => "Janaki", :father_email => "srikanth@ostrylabs.com", :mother_email => "srikanth@ostryalabs.com", :user_id => User.find_by_role_id(Role.find_by_code("parent")))
end

def seed_students
  student = StudentMaster.first
  unless student.present?
    StudentMaster.create(:name => "Sankl", :dob => "17-06-1989", :joining_date => DateTime.now, :academic_year => "#{DateTime.now.year}-#{DateTime.now.year+1}", :parent_id => Parent.first.id, :grade_master_id => GradeMaster.first.id)
    StudentMaster.create(:name => "Srikanth", :dob => "17-06-1989", :joining_date => DateTime.now, :academic_year => "#{DateTime.now.year}-#{DateTime.now.year+1}", :parent_id => Parent.first.id, :grade_master_id => GradeMaster.last.id)
  end
end

def seed_sections
  unless SectionMaster.first.present?
    grademasters=GradeMaster.all
    SectionMaster.create(:section => 'A', :grade_master_id => grademasters[0]['id'])
    SectionMaster.create(:section => 'B', :grade_master_id => grademasters[0]['id'])
    SectionMaster.create(:section => 'C', :grade_master_id => grademasters[1]['id'])
    SectionMaster.create(:section => 'D', :grade_master_id => grademasters[1]['id'])
    SectionMaster.create(:section => 'E', :grade_master_id => grademasters[2]['id'])
  end
end
def seed_subjects
  unless SubjectMaster.first.present?
    SubjectMaster.create(:subject => 'PHYSICS')
    SubjectMaster.create(:subject => 'CHEMISTRY')
    SubjectMaster.create(:subject => 'MATHEMATICS')
    SubjectMaster.create(:subject => 'ENGLISH')
    SubjectMaster.create(:subject => 'TELUGU')    
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

def seed_faculty
  unless FacultyMaster.first.present?
    FacultyMaster.create(:faculty_name => 'SRIKANTH')
    FacultyMaster.create(:faculty_name => 'MURALEE')
    FacultyMaster.create(:faculty_name => 'SWAMY')
    FacultyMaster.create(:faculty_name => 'PRIYA')
    FacultyMaster.create(:faculty_name => 'NAVYA')
    FacultyMaster.create(:faculty_name => 'UMA')
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




def seed_all
  seed_role
  seed_user
  seed_jobs
  seed_payment_types
  seed_grades
  seed_parents
  seed_students
  seed_sections
  seed_subjects
  seed_defaults
  seed_default_discount
  seed_faculty
  seed_tecaher_grade_mapping
end

seed_all
