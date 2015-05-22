class AdminDashboardsController < ApplicationController
  # def index
  #   respond_to do |format|
  #     format.json do
  #       @admissions = Admission.select(:status).group(:status).count
  #       render :json => @admissions
  #     end
  #     format.html do
  #       @admissions = Admission.select(:status).group(:status).count
  #     end
  #   end
  # end

  def get_count_status
    respond_to do |format|
      format.json do
        @admissions = Admission.select("status, count(*) as count").group("status")
        # .where.not(:status => 'Form Closed')
        @report_adm = @admissions.map{|ad| {:status => ad.status, :count => ad.count}}
        render :json => @report_adm
      end
    end
  end



  def get_forms
    p "111111111111"
    p params[:status]
    respond_to do |format|
      format.json do
        render :json => Admission.all.where(:status => params[:status])
      end
    end
  end



  def get_staff_count_status
    respond_to do |format|
      format.json do
        @admissions = Staffrecruit.select("status, count(*) as count").group("status")
        # .where.not(:status => 'Form Closed')
        @report_adm = @admissions.map{|ad| {:status => ad.status, :count => ad.count}}
        render :json => @report_adm
      end
    end
  end



  def get_staff_forms
    p "111111111111"
    p params[:status]
    respond_to do |format|
      format.json do
        render :json => Staffrecruit.all.where(:status => params[:status])
      end
    end
  end


























end
