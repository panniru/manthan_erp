class LabMastersController < ApplicationController
  # def get_faculty_id_view
  #   lab_new_masters = FacultyMaster.all.map do |x|
  #     { faculty_id: x.id, faculty_name: x.faculty_name}
  #   end
  #   render :json => lab_new_masters
  # end      

  def index
    @subject_masters= SubjectMaster.all
    @subject_master= SubjectMaster.new
  end

  def new
    p "=====================+++++++++++++++"
    @subject_master= SubjectMaster.new
  end

  def create
   p params
    p "111====================="
    @subject_master = SubjectMaster.new(subject_master_params)
    if @subject_master.save
      p @subject_master
      redirect_to lab_masters_path
    else
      render 'new'
    end
  end

  def show
    @subject_master=SubjectMaster.find(params[:id]) 
  end
 

  # def destroy
  #   @subject_master = SubjectMaster.find(params[:id])
  #   @subject_master.destroy

  #   redirect_to lab_masters_path
  # end

  private
  def subject_master_params
    params.require(:subject_master).permit(:subject_name , :subject_type)
  end

  def lab_master_params
    params.require(:lab_master).permit(:lab_name,:faculty_id)
  end

end
