class TeachingPlansController < ApplicationController
  def index
    @teaching_plans = TeachingPlan.all
    @teaching_plans = TeachingPlan.find(:all, :order => 'teaching_date,plan_month')
  # @teaching_plans = @teaching_plans.group_by { |t| t.teaching_date.beginning_of_month }
  end
  def calendardata   
    @teaching_plans = TeachingPlan.all
  end
  
  def new
    @teaching_plan = TeachingPlan.new
  end
  def edit
    @teaching_plan = TeachingPlan.find(params[:id])
  end
  def update
    @teaching_plan = TeachingPlan.find(params[:id])
    if @teaching_plan.update(teachingplan_params)
      flash[:success] = I18n.t :success, :scope => [:teachingplan, :update]
      redirect_to teaching_plans_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:teachingplan, :update]
      render "edit"
    end
  end
  def show
    @teaching_plan = TeachingPlan.find(params[:id])
  end
  
  def create
    @teaching_plan = TeachingPlan.new(teachingplan_params)
    respond_to do |format|
      
      if @teaching_plan.save
        format.html { redirect_to @teaching_plan, notice: 'Plan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @teaching_plan }
      else
        format.html { render action: 'new' }
        format.json { render json: @teaching_plan.errors, status: :unprocessable_entity }
      end
    end
  end
  def teachingplan_params
    params.require(:teaching_plan).permit(:grade_master_id, :section_master_id,:teaching_date,:plan_month,:faculty_master_id,:subject_master_id )
  end
  def getfacultyidservice   
    respond_to do |format|
      format.json do
        c =User.find(current_user)       
        faculty = FacultyMaster.where('user_id = '+"#{c.id}")        
        faculty = faculty.map do |fac|
          {id: fac.id}
        end       
        render :json => faculty
      end
    end
  end
  def getgradessectionsservice    
    faculty_id = params[:_faculty_id].to_i
    respond_to do |format|
      format.json do
        mappings = TeacherGradeMapping.where('faculty_master_id='+"#{faculty_id}")     
        mappings = mappings.map do |mapping|          
          {:grade_master_id => mapping.grade_master_id, :grade_name => mapping.grade_master.grade_name,:section_master_id => mapping.section_master_id, :section_name => mapping.section_master.section_name}
          
        end
        
        render :json => mappings
        # end 
      end     
    end
  end
  def get_grade_section_subject_service    
    faculty_id = params[:_faculty_id].to_i
    respond_to do |format|
      format.json do
        mappings = TeacherGradeMapping.where('faculty_master_id='+"#{faculty_id}")     
        mappings = mappings.map do |mapping|          
          {:id => faculty_id, :grade_master_id => mapping.grade_master_id, :grade_name => mapping.grade_master.grade_name,:section_master_id => mapping.section_master_id, :section_name => mapping.section_master.section_name, :subject_master_id => mapping.subject_master_id, :subject_name => mapping.subject_master.subject_name, :grade_section_subject => (mapping.grade_master.grade_name+"- "+mapping.section_master.section_name+"- "+mapping.subject_master.subject_name)}
          
        end
        p mappings
        p "=======>"
        
        render :json => mappings
        # end 
      end     
    end
  end
end
