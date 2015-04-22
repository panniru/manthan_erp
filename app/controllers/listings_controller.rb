class ListingsController < ApplicationController
 
  def index
    @listings = Listing.all
    @listing = Listing.new
  
    if current_user.admin?
      render "admin_form"
    elsif current_user.teacher?
      render "index"
    end
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
        @list = Listing.where(:grade_master_id => a, :subject_master_id => b).map do |x|
          {listing_id: x.id,grade_name: x.grade_master.grade_name, subject_name: x.subject_master.subject_name, assessment_date: x.assessment_date, assessment_description: x.assessment_description, assessment_name: x.assessment_name,union: x.union, grade_master_id: x.grade_master_id}
        end
        render :json => @list
      end
    end
  end


  def new
    @listing = Listing.new
  end



  def lab_params
    params.require(:listing).permit(:lab_assessment_id, :assessment_name, :assessment_description, :subject_master_id, :assessment_date, :grade_master_id, :selected_user, :union,:grade_name,:subject_name)
  end
 
  
end
