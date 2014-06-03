class TimeTablesController < ApplicationController
	def index
	end
	def gradeServiceView
    	respond_to do |format|
      		format.json do
        	render :json => Grade.all
      	end
    end  
end
