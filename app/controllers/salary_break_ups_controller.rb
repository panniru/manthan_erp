class SalaryBreakUpsController < ApplicationController
  before_action :set_salary_break_up, only: [:show, :edit, :update, :destroy]
  
  # GET /salary_break_ups
  # GET /salary_break_ups.json
  def index
    respond_to do |format|
      @type = params[:type]
      format.html{ render "index"}
      format.json do
        case @type.present? 
        when @type.to_sym == :pf
          @salary_break_ups = SalaryBreakUp.belongs_to_pf.order("id")
        when @type.to_sym == :salary
          @salary_break_ups = SalaryBreakUp.belongs_to_salary.order("id")
        when @type.to_sym == :default
          @salary_break_ups = SalaryBreakUp.belongs_to_default.order("id")
        end
        renderg json: @salary_break_ups, methods: [:component_description, :component_value]
        
      end
    end
  end

  # GET /salary_break_ups/1
  # GET /salary_break_ups/1.json
  def show
  end

  # GET /salary_break_ups/new
  def new
    @salary_break_up = SalaryBreakUp.new
  end

  # GET /salary_break_ups/1/edit
  def edit
  end

  # POST /salary_break_ups
  # POST /salary_break_ups.json
  def create
    @salary_break_up = SalaryBreakUp.new(salary_break_up_params)

    respond_to do |format|
      if @salary_break_up.save
        format.html { redirect_to salary_break_ups_path, notice: 'Salary break up was successfully created.' }
        format.json { render action: 'show', status: :created, location: @salary_break_up }
      else
        format.html { render action: 'new' }
        format.json { render json: @salary_break_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salary_break_ups/1
  # PATCH/PUT /salary_break_ups/1.json
  def update
    respond_to do |format|
      if @salary_break_up.update(salary_break_up_params)
        format.html { redirect_to salary_break_ups_path, notice: 'Salary break up was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @salary_break_up.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_all
    respond_to do |format|
      salary_break_ups = generate_salary_break_ups_for_update_all
      if salary_break_ups.map(&:valid?).all?
        salary_break_ups.map(&:save!)
        format.html { redirect_to salary_break_ups_path, notice: 'Salary break up was successfully updated.' }
        format.json { render json: {status: true}}
      else
        format.html { render action: 'edit' }
        format.json { render json: salary_break_ups.map{|m| m.errors.messages}, status: false }
      end
    end
  end


  # DELETE /salary_break_ups/1
  # DELETE /salary_break_ups/1.json
  def destroy
    @salary_break_up.destroy
    respond_to do |format|
      format.html { redirect_to salary_break_ups_url }
      format.json { head :no_content }
    end
  end

  def break_up_report
    respond_to do |format|
      format.json do
        @probation_date = Date.strptime(params[:probation_date], "%d-%m-%Y") if params[:probation_date].present?
        render :json => Payroll::SalaryBreakUpCreator.new(params[:ctc].to_f, params[:basic].try(:to_f), @probation_date, session[:transaction_date], params[:designation]).to_h
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_salary_break_up
    @salary_break_up = SalaryBreakUp.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def salary_break_up_params
    params.require(:salary_break_up).permit(:component, :criteria)
  end
  
  def generate_salary_break_ups_for_update_all
    params[:salary_break_ups].map do |param|
      salary_break_up = SalaryBreakUp.find(param[:id])
      salary_break_up.criteria = param[:criteria]
      salary_break_up
    end
  end
end
