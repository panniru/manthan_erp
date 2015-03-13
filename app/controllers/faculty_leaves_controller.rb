class FacultyLeavesController < ApplicationController

  def index
    @faculty_leaves = FacultyLeave.select('DISTINCT year,month')
  end

  def create
    @faculty_leaves = FacultyLeave.new(faculty_leave_params)
    if @faculty_leaves.save
      flash.now[:success] = I18n.t :success, :scope => [:faculty_leave, :create]
      render "index"
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:faculty_leave, :create]
      render "new"
    end
  end

  def upload
    @faculty_leave_uploader = FacultyLeaveUploader.new(params[:faculty_leave_uploader])
    if @faculty_leave_uploader.save
      flash[:success] = "Faculty Successfully uploaded"
      redirect_to faculty_leaves_path
    else
      flash[:error] = "Some problem occured while uploading.."
      render "new_upload"
    end
  end

  def new_upload
    require 'spreadsheet'
    Spreadsheet.client_encoding = 'UTF-8'
    employee_leave = Spreadsheet::Workbook.new
    sheet1 = faculty_leave.create_worksheet :name => 'Faculty Leaves'
    sheet1.row(0).push "Code"
    sheet1.row(0).push "Days Worked"
    sheet1.row(0).push "Working Days"
    sheet1.row(0).push "Sl"
    sheet1.row(0).push "Cl"
    sheet1.row(0).push "Pl"
    sheet1.row(0).push "Lop"

    spreadsheet = StringIO.new
    faculty_leave.write spreadsheet
    file = "Faculty_Leaves_Sample.xlsx"
    send_data spreadsheet.string, :filename => "#{file}", :type =>  "application/vnd.ms-excel"
  end

  def export
    require 'spreadsheet'
    Spreadsheet.client_encoding = 'UTF-8'
    faculty_leave = Spreadsheet::Workbook.new
    sheet1 = faculty_leave.create_worksheet :name => 'Faculty Leaves'
    sheet2 = faculty_leave.create_worksheet :name => 'Encahment Leaves'
    
    sheet2.row(0).push "Employee Id"
    sheet2.row(0).push "No of leaves to be encashed" 
    sheet1.row(0).push "Code"
    sheet1.row(0).push "Days Worked"
    sheet1.row(0).push "Working Days"
    sheet1.row(0).push "Sl"
    sheet1.row(0).push "Cl"
    sheet1.row(0).push "Pl"
    sheet1.row(0).push "Lop"
    
    spreadsheet = StringIO.new
    faculty_leave.write spreadsheet
    file = "Faculty_Leaves_Sample.xlsx"
    send_data spreadsheet.string, :filename => "#{file}", :type =>  "application/vnd.ms-excel"
  end

  
  def show
    @faculty_leave_uploader = FacultyLeaveUploader.new
    respond_to do |format|
      format.html { render "new_upload"}
      
    end
  end
  
  def edit
    @faculty_leave = FacultyLeave.find(params[:id])
  end

  def corresponding_month
    page = params[:page].present? ? params[:page] : 1
    @faculty_leaves = FacultyLeave.includes(:faculty_master).month(params[:month]).year(params[:year]).all.order("faculty_masters.code").paginate(:page => page)
  end
    

  

  def update
    @faculty_leave = FacultyLeave.find(params[:id])
    if @faculty_leave.update(faculty_leave_params)
      flash[:success] = I18n.t :success, :scope => [:faculty_leave, :update]
      redirect_to faculty_leaves_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:faculty_leave, :update]
      render "edit"
    end
  end
  
  
 
  private
  def faculty_leave_params
    params.require(:faculty_leave).permit(:faculty_master_id , :lop , :month ,:year,:entered_date , :days_worked, :working_days , :code , :sl , :pl , :cl)
  end
end
