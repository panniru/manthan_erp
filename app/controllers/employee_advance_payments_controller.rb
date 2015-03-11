class EmployeeAdvancePaymentsController < ApplicationController
  before_action :load_faculty_master
  load_resource :only => [:show, :update, :edit, :destroy]
  authorize_resource

  def index
    @employee_advance_payments = @faculty_master.employee_advance_payments.all
  end

  def search_by_month
    @employee_advance_payments = @faculty_master.employee_advance_payments.belongs_to_month(params[:month]).belongs_to_year(params[:year])
    render "index"
  end

  def new
    @employee_advance_payment = EmployeeAdvancePayment.new do |adv_payment|
      adv_payment.payment_date = session[:transaction_date]
      adv_payment.faculty_master = @faculty_master
    end
  end

  def show
  end

  def create
    @employee_advance_payment = EmployeeAdvancePayment.new(employee_advance_payment_params)
    @employee_advance_payment.status = "generated"
    respond_to do |format|
      if @employee_advance_payment.save
        format.html { redirect_to faculty_master_employee_advance_payments_path(@faculty_master), notice: 'Faculty advance payment has been added' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @employee_advance_payment.update(employee_advance_payment_params)
        format.html { redirect_to faculty_master_employee_advance_payments_path(@faculty_master), notice: 'Advance payment was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def edit
  end
  
  def destroy
    @employee_advance_payment.destroy
    respond_to do |format|
      format.html { redirect_to faculty_master_employee_advance_payments_path(@faculty_master) }
    end
  end


  private

  def load_faculty_master
    @faculty_master = FacultyMaster.find(params[:faculty_master_id])
    unless @faculty_master.readable_by_user? current_user
      raise CanCan::AccessDenied
    end
  end
  
  def employee_advance_payment_params
    params.require(:employee_advance_payment).permit(:faculty_master_id, :payment_date, :amount_in_rupees)
  end

end
