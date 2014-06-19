# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl_rails'


def seed_role
  @admin_role = Role.find_by_code("admin")
  @parent_role = Role.find_by_code("parent")
  @accountant_role = Role.find_by_code("accountant")

  unless @admin_role.present?
    Role.create(:role => "admin", :code => "admin", :description => "admin")
  end

  unless @parent_role.present?
    Role.create(:role => "parent", :code => "parent", :description => "parent")
  end

  unless @accountant_role.present?
    Role.create(:role => "accountant", :code => "accountant", :description => "accountant")
  end
  
end


def seed_user
  admin_role = Role.find_by_code("admin")
  parent_role = Role.find_by_code("parent")
  accountant_role = Role.find_by_code("accountant")
  
  @user_admin = User.find_by_role_id(admin_role)
  @user_parent = User.find_by_role_id(parent_role)
  @user_accountant = User.find_by_role_id(accountant_role)
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
  Parent.first_or_create(:father_name => "Raghu", :mother_name => "Janaki", :father_email => "srikanth@ostrylabs.com", :mother_email => "srikanth@ostryalabs.com")
end

def seed_students
  student = StudentMaster.first
  unless student.present?
    StudentMaster.create(:name => "Sankl", :dob => "17-06-1989", :joining_date => DateTime.now, :academic_year => "#{DateTime.now.year}-#{DateTime.now.year+1}", :parent_id => Parent.first.id, :grade_master_id => GradeMaster.find("2").id)
    StudentMaster.create(:name => "Sankl", :dob => "17-06-1989", :joining_date => DateTime.now, :academic_year => "#{DateTime.now.year}-#{DateTime.now.year+1}", :parent_id => Parent.first.id, :grade_master_id => GradeMaster.find("4").id)
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
end

seed_all
