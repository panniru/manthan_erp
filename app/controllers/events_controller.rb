class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  def get_faculty_view
    faculty = TeacherLeader.all.map do |faculty|
      {faculty_name: faculty.faculty_leader, id: faculty.id}
      end
    render :json => faculty
  end
  # GET /events
  # GET /events.json
  def index
    
    @events = Event.all
  end
  
  # GET /events/1
  # GET /events/1.json
  def show
  end
  
  # GET /events/new
  def new
    @admissions = Admission.all
    @event = Event.new
    
  end
  


# GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
   
    @event = Event.new(event_params)
    @event.teacher_leader = TeacherLeader.where(:klass => event_params[:grade]).first
     respond_to do |format|
      if @event.save
        format.html { redirect_to admission_home_admissions_path, notice: 'Assessment was successfully planned.' }
      else
        format.html { render action: 'new' }
      end
    end
  end
 
  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :staff, :grade, :start_time, :end_time, :admission_id, :status)
    end
end
