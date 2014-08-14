class CanteenmanagersController < ApplicationController
  def index
    @canteenmanagers = Canteenmanager.all
  end
  def new
    @canteenmanager = Canteenmanager.new
  end

end
