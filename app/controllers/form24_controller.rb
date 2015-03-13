class Form24Controller < ApplicationController
  
  def index
    @forms = Form24.select(:financial_year, :quarter).group(:financial_year, :quarter)
  end
  
  def get_annexure_report
    respond_to do |format|
      if params[:year].present?
        year_from = params[:year].split('-')[0].to_i
        year_to = params[:year].split('-')[1].to_i
        from_date = Date.new(year_from , 04, 1)
        to_date = Date.new(year_to , 03, 31)
        @forms = SalaryTax.manageable_by_current_user(current_user).in_the_financial_year(from_date , to_date).all
      else
        @forms = SalaryTax.manageable_by_current_user(current_user).all
      end
      format.pdf do
        render :json => @forms
      end
      format.pdf do
        render :pdf => "Annexure",
        :formats => [:pdf, :haml],
        :page_size => 'A4',
        :margin => {:top => '8mm',
          :bottom => '8mm',
          :left => '10mm',
          :right => '10mm'}
      end
    end 
  end

  def annexure
    if params[:year].present?
      year_from = params[:year].split('-')[0].to_i
      year_to = params[:year].split('-')[1].to_i
      @from_date = Date.new(year_from , 04, 1)
      @to_date = Date.new(year_to , 03, 31)
      @showing_year = params[:year]
    else
      fin_year_cal = Payroll::FinancialYearCalculator.new(session[:transaction_date])
      @from_date = fin_year_cal.financial_year_from
      @to_date = fin_year_cal.financial_year_to
      @showing_year = fin_year_cal.financial_year
    end
    @salary_taxes = SalaryTax.manageable_by_current_user(current_user).in_the_financial_year(@from_date , @to_date).all
    @form24_q_annexure2s = @salary_taxes.map{|salary_tax| Payroll::Form24QAnnexure2.new(salary_tax)}

    respond_to do |format|
      format.html{}
      format.pdf do
        render :pdf => "Annexure",
        :formats => [:pdf],
        :page_size => 'A4',
        :orientation => 'Landscape',
        :margin => {:top => '8mm',
          :bottom => '8mm',
          :left => '10mm',
          :right => '10mm'}
      end
    end
  end
 
  
  def show
    @forms = Payslip.where(:generated_date => params[:generated_date])
  end
  
  def payslips
    page = params[:page].present? ? params[:page] : 1
    @form24 = Form24.find(params[:id])
    @date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    @quarter_no =  Payroll::FinancialYearCalculator.new(@date).current_quarter_num
    @payslips = PayslipDecorator.decorate_collection(Payslip.manageable_by_user(current_user).in_the_year(params[:year]).in_the_mon(params[:month]).pays_tds.sort_on_employee_code)
  end
  
  def quarter_details
    @forms = Payroll::Form24QAnnexure1.new(current_user, params[:financial_year], params[:quarter]).generate_form_24_q
  end


  def print_annexure1
    respond_to do |format|
      form24q_annexure1 = Payroll::Form24QAnnexure1.new(current_user, params[:financial_year], params[:quarter])
      @form_24_months = form24q_annexure1.month_wise_showcase
      format.html{
      }
      format.pdf do
        render :pdf => "Form24Q_Annexure_1_#{params[:financial_year]}_#{params[:quarter]}",
        :formats => [:pdf],
        :page_size => 'A4',
        :orientation => 'Landscape',
        :margin => {:top => '8mm',
          :bottom => '8mm',
          :left => '10mm',
          :right => '10mm'}
      end
    end
  end



   
  def edit
  end
  
  def create
  end
  
  def new
    last_quarter_date = session[:transaction_date].beginning_of_quarter-1
    fin_year_cal =  Payroll::FinancialYearCalculator.new(last_quarter_date)
    current_quarter = fin_year_cal.current_quarter_num
    if Form24.in_the_quarter(current_quarter).in_the_financial_year(fin_year_cal.financial_year).count >  0
      flash[:alert] = "Form24 has already been generated for the quarter"
      redirect_to form24_index_path
    end
  end

  def get_tds
    @date = session[:transaction_date].beginning_of_quarter-1
    fin_year_cal =  Payroll::FinancialYearCalculator.new(@date) 
    form_24_q_val_objs = Payroll::Form24QAnnexure1.new(current_user, fin_year_cal.financial_year, fin_year_cal.current_quarter_num).manage_form24
    respond_to do |format|
      format.json do
        render :json => form_24_q_val_objs
      end
    end
  end
  
  
  def save_form
    respond_to do |format|
      format.json do
        form_details = params[:form_details]
        form_details.each do |form_attributes|
          form24 = Form24.where(:id => form_attributes["id"]).first || Form24.new
          form24.assign_attributes(form24_params(form_attributes))
          form24.save
        end
        redirect_to form24_index_path
      end
    end
  end

  



  def form24_params(parameters)
    parameters.permit("quarter", "financial_year", "cheque_no", "created_date", "emp_status", "month", "year", "deposited_date", "challan_serial_no", "bsr_code", "payment_type")
  end
  
end
