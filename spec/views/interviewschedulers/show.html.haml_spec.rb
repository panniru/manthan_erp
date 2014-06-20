require 'rails_helper'

RSpec.describe "interviewschedulers/show", :type => :view do
  before(:each) do
    @interviewscheduler = assign(:interviewscheduler, Interviewscheduler.create!(
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
  end
end
