require 'rails_helper'

RSpec.describe "staffs/index", :type => :view do
  before(:each) do
    assign(:staffs, [
      Staff.create!(
        :staff_name => "Staff Name",
        :staff_exp => "Staff Exp",
        :grade => "Grade",
        :start_time => "Start Time",
        :end_time => "End Time",
        :period => "Period",
        :date => "Date"
      ),
      Staff.create!(
        :staff_name => "Staff Name",
        :staff_exp => "Staff Exp",
        :grade => "Grade",
        :start_time => "Start Time",
        :end_time => "End Time",
        :period => "Period",
        :date => "Date"
      )
    ])
  end

  it "renders a list of staffs" do
    render
    assert_select "tr>td", :text => "Staff Name".to_s, :count => 2
    assert_select "tr>td", :text => "Staff Exp".to_s, :count => 2
    assert_select "tr>td", :text => "Grade".to_s, :count => 2
    assert_select "tr>td", :text => "Start Time".to_s, :count => 2
    assert_select "tr>td", :text => "End Time".to_s, :count => 2
    assert_select "tr>td", :text => "Period".to_s, :count => 2
    assert_select "tr>td", :text => "Date".to_s, :count => 2
  end
end
