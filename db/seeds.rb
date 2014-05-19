# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def seed_user
  @user_admin = User.find_by_role("admin")
  unless @user_admin.present?
    User.create(:email => "admin@manthan.com", :password => "welcome", :user_name => "admin", :role => "admin")
  end
end

def seed_all
  seed_user
end

seed_all
