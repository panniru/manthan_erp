require 'rails_helper'

RSpec.describe "interviewschedulers/edit", :type => :view do
  before(:each) do
    @interviewscheduler = assign(:interviewscheduler, Interviewscheduler.create!(
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit interviewscheduler form" do
    render

    assert_select "form[action=?][method=?]", interviewscheduler_path(@interviewscheduler), "post" do

      assert_select "input#interviewscheduler_name[name=?]", "interviewscheduler[name]"

      assert_select "input#interviewscheduler_description[name=?]", "interviewscheduler[description]"
    end
  end
end
