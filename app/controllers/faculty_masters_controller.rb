class FacultyMastersController < ApplicationController
  load_resource :only => [:dashboard]
  authorize_resource
  
  def index
    @faculty = FacultyMaster.all
  end

  def dashboard
  end

  def autocomplete_employee
    term = params[:term]
    employees = FacultyMaster.managed_by(current_user).where('lower(code) ILIKE ? OR lower(faculty_name) LIKE ?', "%#{term.downcase}%", "%#{term.downcase}%").order(:faculty_name).all
    render :json => employees.map { |employee| {:id => employee.id, :label => "#{employee.code} #{employee.faculty_name}", :value => employee.faculty_name} }
  end

  def update
    @faculty_master = FacultyMaster.find(params[:id])
  end
  
  def faculty_upload
  end
  
  def create
    @faculty_master = FacultyMaster.new(faculty_master_params)
    respond_to do |format|
      if @faculty_master.save_employee
        format.html { redirect_to @faculty_master, notice: 'Faculty was successfully created.' }
        format.json { render action: 'show', status: :created, location: @faculty_master }
      else
        format.html { render action: 'new' }
        format.json { render json: @faculty_master.errors, status: :unprocessable_entity }
      end
    end
  end
  def show
    @faculty_master = FacultyMaster.find(params[:id])
  end

  def faculty_master_params
    params.require(:faculty_master).permit(:code, :faculty_name, :designation_master_id, :department_master_id, :gender, :initials, :qualification, :date_of_joining, :probation_date, :confirmation_date, :p_f_no, :bank_name, :account_number, :pan, :designation_name, :department_name, :ctc, :basic, :father_or_husband_name, :relation, :resignation_date, :reason_for_resignation, :status, :dob)
  end
end
