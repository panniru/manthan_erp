class SetupMastersController < ApplicationController
  
  def get_designations
    designations = Designation.all.map do |designation|
      {designation: designation.designation}
    end
    render :json => designations
  end

  def index
    @setup_masters = SetupMaster.all
    respond_to do |format|
      format.json do
        @setup_masters = SetupMaster.all
        render :json => @setup_masters
      end
      format.html do 
        render "index"
      end
    end
  end
  

  def create
    @setup_master = SetupMaster.new(setup_master_params)
    respond_to do |format|
      if @setup_master.save 
        format.html { redirect_to setup_masters_path, notice: 'Leave was successfully created.' }
        
      else
        format.html { redirect_to setup_masters_path, notice: 'Designation was assigned already.' }
      end
    end
  end
  
  def update
    @setup_master = SetupMaster.find(params[:id])
    if @setup_master.update(setup_master_params)
      redirect_to setup_masters_path
    else
      render "edit"
    end
  end




  def setup_master_params
    params.require(:setup_master).permit(:designation, :casual_leave, :sick_leave)
  end



end
