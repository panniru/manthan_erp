require 'rails_helper'

RSpec.describe "staffs/edit", :type => :view do
  before(:each) do
    @staff = assign(:staff, Staff.create!(
      :staff_name => "MyString",
      :staff_exp => "MyString",
      :grade => "MyString",
      :start_time => "MyString",
      :end_time => "MyString",
      :period => "MyString",
      :date => "MyString"
    ))
  end

  it "renders the edit staff form" do
    render

    assert_select "form[action=?][method=?]", staff_path(@staff), "post" do

      assert_select "input#staff_staff_name[name=?]", "staff[staff_name]"

      assert_select "input#staff_staff_exp[name=?]", "staff[staff_exp]"

      assert_select "input#staff_grade[name=?]", "staff[grade]"

      assert_select "input#staff_start_time[name=?]", "staff[start_time]"

      assert_select "input#staff_end_time[name=?]", "staff[end_time]"

      assert_select "input#staff_period[name=?]", "staff[period]"

      assert_select "input#staff_date[name=?]", "staff[date]"
    end
  end
end
