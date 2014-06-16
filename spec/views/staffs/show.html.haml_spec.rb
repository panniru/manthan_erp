require 'rails_helper'

RSpec.describe "staffs/show", :type => :view do
  before(:each) do
    @staff = assign(:staff, Staff.create!(
      :staff_name => "Staff Name",
      :staff_exp => "Staff Exp",
      :grade => "Grade",
      :start_time => "Start Time",
      :end_time => "End Time",
      :period => "Period",
      :date => "Date"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Staff Name/)
    expect(rendered).to match(/Staff Exp/)
    expect(rendered).to match(/Grade/)
    expect(rendered).to match(/Start Time/)
    expect(rendered).to match(/End Time/)
    expect(rendered).to match(/Period/)
    expect(rendered).to match(/Date/)
  end
end
