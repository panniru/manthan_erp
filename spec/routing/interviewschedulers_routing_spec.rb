require "rails_helper"

RSpec.describe InterviewschedulersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/interviewschedulers").to route_to("interviewschedulers#index")
    end

    it "routes to #new" do
      expect(:get => "/interviewschedulers/new").to route_to("interviewschedulers#new")
    end

    it "routes to #show" do
      expect(:get => "/interviewschedulers/1").to route_to("interviewschedulers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/interviewschedulers/1/edit").to route_to("interviewschedulers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/interviewschedulers").to route_to("interviewschedulers#create")
    end

    it "routes to #update" do
      expect(:put => "/interviewschedulers/1").to route_to("interviewschedulers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/interviewschedulers/1").to route_to("interviewschedulers#destroy", :id => "1")
    end

  end
end
