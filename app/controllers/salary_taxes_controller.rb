class SalaryTaxesController < ApplicationController
  before_action :load_faculty_master, :except => [:tax_limits]
  load_resource :only => [:show, :update, :edit, :form16]
  authorize_resource

  def show
    respond_to do |format|
      format.html{}
      format.pdf do
        render :pdf => "#{@faculty_master.faculty_name}_salary_tax_in_#{session[:financial_year]}",
        :formats => [:pdf],
        :page_size => 'A4'
      end
    end
  end

  def form16
    #@salary_tax = @employee_master.salary_taxes.in_the_financial_year(session[:financial_year_from], session[:financial_year_to]).first
    @form16 =  Payroll::Form16.new(@faculty_master, @salary_tax)
    respond_to do |format|
      format.html{}
      format.pdf do
        render :pdf => "#{@faculty_master.faculty_name}_form_16.pdf",
        :formats => [:pdf],
        :page_size => 'A4'
      end
    end
  end


  def index
    @salary_taxes = @faculty_master.salary_taxes
  end
  
  def new
    @salary_tax = @faculty_master.salary_taxes.in_the_financial_year(session[:financial_year_from], session[:financial_year_to]).first
    respond_to do |format|
      format.html do
        if @salary_tax.present?
          flash[:alert] = "Salary Tax has already been generated to the employee <b> #{@faculty_master.name}</b> in the year #{session[:financial_year]}"
          redirect_to faculty_master_salary_taxes_path(@faculty_master)
        end
      end
      format.json do
        @salary_tax = Payroll::SalaryTaxCreationService.new_salary_tax(@faculty_master, session[:financial_year_from], session[:financial_year_to])
        render :json => @salary_tax, methods: [:final_hra_component]
      end
    end
  end
  
  def create
    respond_to do |format|
      format.html {
        @salary_tax =  Payroll::SalaryTaxCreationService.new(@faculty_master, params[:salary_tax], session[:financial_year_from], session[:financial_year_to]).create
        if @salary_tax.present?
          flash[:success] = "Salary Tax has been generated succesfully"
          redirect_to faculty_master_salary_tax_path(@faculty_master, @salary_tax)
        else
          flash[:error] = "Salary Tax has not been generated"
          render "new"
        end
      }
      format.json do
        @salary_tax =  Payroll::SalaryTaxCreationService.new(@faculty_master, params[:salary_tax], session[:financial_year_from], session[:financial_year_to]).create
        render :json => {:status => @salary_tax.present?, :id =>  @salary_tax.try(:id)} 
      end
    end
  end


  def update
    respond_to do |format|
      format.json do
        status =  Payroll::SalaryTaxCreationService.new(@faculty_master, params[:salary_tax], session[:financial_year_from], session[:financial_year_to]).update(@salary_tax)
        render :json => {:status => status}
      end
    end
  end
  
  def edit
    respond_to do |format|
      format.html {}
      format.json do
        @salary_tax.medical_bills << MedicalBill.new if @salary_tax.medical_bills.empty?
        @salary_tax.savings << Saving.new if @salary_tax.savings.empty?
        @salary_tax.medical_insurances << MedicalInsurance.new if @salary_tax.medical_insurances.empty?
        render :json => @salary_tax
      end
    end
  end
  
  def tax_limits
    respond_to do |format|
      format.json do
        render :json => SalaryTax.tax_limits
      end
    end
  end

  def component_monthly_report
    respond_to do |format|
      format.json do
        salary_tax_break_up = Payroll::SalaryTaxBreakup.new(@faculty_master, session[:financial_year_from], session[:financial_year_to])
        render :json => salary_tax_break_up.payslip_components_monthly_report(params[:component])
      end
    end
  end

  def email
    SalaryTaxMailer.salary_tax(@salary_tax).deliver
    flash[:success] = "Salary Tax Mailed Successfully"
    render 'show'
  end
  
  private
  
  def load_faculty_master
    @faculty_master = FacultyMaster.find(params[:faculty_master_id])
    unless @faculty_master.readable_by_user? current_user
      raise CanCan::AccessDenied
    end
  end


end
