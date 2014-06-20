require 'rails_helper'

RSpec.describe "Interviewschedulers", :type => :request do
  describe "GET /interviewschedulers" do
    it "works! (now write some real specs)" do
      get interviewschedulers_path
      expect(response.status).to be(200)
    end
  end
end
