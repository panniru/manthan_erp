class GradeLabMappingsController < ApplicationController
  def index
  end
  def get_grades_subjects_service_view
    a = GradeMaster.all.map do |b|
      {grade_name: b.grade_name }
    end
    render :json => a
  end
  def all_subjects
    # subject_masters = SubjectMaster.get_sub_type.map do |subject_master|
    #   {lab_name: subject_master.subject_name , id: subject_master.id }
    # end
    # render :json => subject_masters
    subject_names = SubjectMaster.where(subject_type: 'labs') .map do |subject_master|
      {subject_name: subject_master.subject_name , id: subject_master.id }
    end
    render :json => subject_names
  end

  def get_subjects_grades_service_view
    respond_to do |format|
      format.json do       
       subjects_grades = SubjectGrade.all.map do |sg|
          {id: sg.id, grade_master_id: sg.grade_master_id, grade_name: sg.grade_master.grade_name, subject_master_id: sg.subject_master_id, subject_name: sg.subject_master.subject_name} 
        end
        render :json => subjects_grades
      end
    end
  end    

  def save_grades_mappings
   
    respond_to do |format|
      format.json do        
        mappings = params[:mappings]        
        SubjectGrade.all.map do |temp| 
          @value = "false"
          mappings.each do |t|           
            if temp.id == t['id']         
              @value = "true"
            end
          end
          if @value == "false"          
            SubjectGrade.find(temp.id).destroy          
          end
        end
        mappings.each do |t| 
          if t["id"].present?           
            @grade = SubjectGrade.find(t["id"]) 
            @grade.grade_master_id = t['grade_master_id']
            @grade.subject_master_id = t['subject_master_id']
            @grade.save
          else
            @grade=SubjectGrade.new(add_params(t))
            @grade.save
          end
        end 
        render :json => true
      end
    end
  end  
  
  def add_params(params)
    params.permit(:id, :grade_master_id, :subject_master_id)
  end
  
  def new
  end

  def show
  end

  def edit
  end
end
