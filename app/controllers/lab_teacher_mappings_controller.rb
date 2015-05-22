class LabTeacherMappingsController < ApplicationController

  def index
    @subject_masters=SubjectMaster.all
    # respond_to do |format|
    #   format.json do         
    #     @subject_masters = SubjectMaster.all        
    #     render :json => @subject_masters
    #   end
    # end
    # respond_to do |subject_master|
      
    #   subject_master.json { render json: @subject_names}
    # end
   
  end

  def check_subjects_teachers_mapping  
    respond_to do |format|
      format.json do
        labteachermappings = LabTeacherMapping.where('subject_master_id = '+"#{params[:my_Subject]}").count 

        render :json => labteachermappings
        p labteachermappings
      end
    end  
  end

  def getmappings   
    respond_to do |format|
      format.json do
        labsteachermappings = LabTeacherMapping.where('subject_master_id = '+"'#{params[:my_Subject]}'")   
        labsteachermappings = labsteachermappings.all.map do |mapping|
          if  (mapping.faculty_master_id.present?)
            faculty_name = mapping.faculty_master.faculty_name
          else
            faculty_name = nil
          end
          {id: mapping.id, faculty_master_id: mapping.faculty_master_id.to_i ,faculty_name: faculty_name }
        end    
        render :json => labsteachermappings   
      end
    end
  end
  def deletemappings
    respond_to do |format|
      format.json do       
        if params[:_delete_mapping_id].present?
          LabTeacherMapping.find(params[:_delete_mapping_id]).destroy      
        end
        render :json => true
      end
    end
  end

 

  def get_all_subjects
    subject_names = SubjectMaster.where(subject_type: 'labs') .map do |subject_master|
      {subject_name: subject_master.subject_name , id: subject_master.id }
    end
    render :json => subject_names
  end
  
  def save_lab_mappings
    faculty_names = FacultyMaster.all.map do |faculty_master|
      {faculty_name: faculty_master.faculty_name, faculty_master_id: faculty_master.id}
    end
    render :json => faculty_names
  end

  def savemappings
 
    respond_to do |format|
      format.json do  
        params[:mappings].each do |t| 
          if t["id"].present?
            temp = LabTeacherMapping.find(t["id"])
            temp.faculty_master_id = t["faculty_master_id"][0]  
            temp.subject_master_id = t["subject_master_id"]
            temp.save
          else
            @labteachermapping = LabTeacherMapping.new(lab_teacher_mapping(t))
            @labteachermapping.save
          end
        end
        render :json => true
      end
    end
  end
 
 

  # def show
  #   @faculty_master=FacultyMaster.find(params[:id])
  # end
  
  # def new
  #   @subject_master = SubjectMaster.new

  # end
  
  # def create
  #   @subject_master = SubjectMaster.new(lab_teacher_mapping_params)
  #   if @subject_master.save
  #     redirect_to lab_teacher_mappings_path
  #   else
  #     render 'new'
  #   end
  # end
  def lab_teacher_mapping(params)
    params.permit(:id, :subject_master_id, :faculty_master_id)
  end

end


