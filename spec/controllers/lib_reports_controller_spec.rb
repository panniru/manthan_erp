require 'rails_helper'

RSpec.describe LibReportsController, :type => :controller do

  describe "GET new,index" do
    it "returns http success" do
      get :new,index
      expect(response).to be_success
    end
  end

end
