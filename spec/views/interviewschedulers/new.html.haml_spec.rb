require 'rails_helper'

RSpec.describe "interviewschedulers/new", :type => :view do
  before(:each) do
    assign(:interviewscheduler, Interviewscheduler.new(
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new interviewscheduler form" do
    render

    assert_select "form[action=?][method=?]", interviewschedulers_path, "post" do

      assert_select "input#interviewscheduler_name[name=?]", "interviewscheduler[name]"

      assert_select "input#interviewscheduler_description[name=?]", "interviewscheduler[description]"
    end
  end
end
