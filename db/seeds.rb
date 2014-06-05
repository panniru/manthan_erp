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
  @user_admin = User.find_by_role_id(Role.find_by_code("admin"))
  @user_parent = User.find_by_role_id(Role.find_by_code("parent"))
  @user_accountant = User.find_by_role_id(Role.find_by_code("accountant"))
  unless @user_admin.present?
    User.create(:email => "admin@manthan.com", :password => "welcome", :user_id => "admin")
  end

  unless @user_parent.present?
    User.create(:email => "parent@manthan.com", :password => "welcome", :user_id => "parent")
  end

  unless @user_accountant.present?
    User.create(:email => "accountant@manthan.com", :password => "welcome", :user_id => "accountant")
  end

end


def seed_jobs
  job_attributes = FactoryGirl.attributes_for(:fee_structure_mailing)
  Job.where(code: job_attributes[:code]).first_or_create!(job_attributes.delete_if { |k,v| k == :code })
end


def seed_payment_types
  PaymentType.where(code: "anually").first_or_create!(:code => "anually")
  PaymentType.where(code: "term_wise").first_or_create!(:code => "term_wise")
  PaymentType.where(code: "monthly").first_or_create!(:code => "monthly")
end

def seed_all
  seed_role
  seed_user
  seed_jobs
  seed_payment_types
end

seed_all
