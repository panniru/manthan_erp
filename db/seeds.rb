# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl_rails'

def seed_user
  @user_admin = User.find_by_role_id("1")
  unless @user_admin.present?
    User.create(:email => "admin@manthan.com", :password => "welcome", :user_id => "admin")
  end
end


def seed_jobs
  job_attributes = FactoryGirl.attributes_for(:fee_structure_mailing)
  Job.where(code: job_attributes[:code]).first_or_create!(job_attributes.delete_if { |k,v| k == :code })
end

def seed_all
  seed_user
  seed_jobs
end

seed_all
