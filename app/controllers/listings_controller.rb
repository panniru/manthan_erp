class ListingsController < ApplicationController
  def index
    @listings = Listing.all
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(lab_params)
    respond_to do |format|
      if @listing.save
        format.html {
          redirect_to listings_path
        }
      else
        format.html{
          redirect_to listings_path
        }
      end
    end
  end
  def get_values
    
    respond_to do |format|
      format.json  do
        @listing = Listing.get_value(params[:selected_user])
        a = params[:selected_user].split('-')[0].to_i
        b = params[:selected_user].split('-')[1].to_i
        @list = Listing.where(:grade_master_id => a, :subject_master_id => b)
        render :json => @list
      end
    end
  end

  def new
    @listing = Listing.new
  end



  def lab_params
    params.require(:listing).permit(:lab_assessment_id, :assessment_name, :assessment_description, :subject_master_id, :assessment_date, :grade_master_id, :selected_user)
  end

  
end
