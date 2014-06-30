class InterviewschedulersController < ApplicationController
  before_action :set_interviewscheduler, only: [:show, :edit, :update, :destroy]

  # GET /interviewschedulers
  # GET /interviewschedulers.json
  def index
    @interviewschedulers = Interviewscheduler.all
    @interviewschedulers = Interviewscheduler.search(params[:search])
  end

  # GET /interviewschedulers/1
  # GET /interviewschedulers/1.json
  def show
  end

  # GET /interviewschedulers/new
  def new
    @interviewscheduler = Interviewscheduler.new
  end

  # GET /interviewschedulers/1/edit
  def edit
  end

  # POST /interviewschedulers
  # POST /interviewschedulers.json
  def create
    @interviewscheduler = Interviewscheduler.new(interviewscheduler_params)

    respond_to do |format|
      if @interviewscheduler.save
        format.html { redirect_to @interviewscheduler, notice: 'Interviewscheduler was successfully created.' }
        format.json { render action: 'show', status: :created, location: @interviewscheduler }
      else
        format.html { render action: 'new' }
        format.json { render json: @interviewscheduler.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interviewschedulers/1
  # PATCH/PUT /interviewschedulers/1.json
  def update
    respond_to do |format|
      if @interviewscheduler.update(interviewscheduler_params)
        format.html { redirect_to @interviewscheduler, notice: 'Interviewscheduler was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @interviewscheduler.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interviewschedulers/1
  # DELETE /interviewschedulers/1.json
  def destroy
    @interviewscheduler.destroy
    respond_to do |format|
      format.html { redirect_to interviewschedulers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interviewscheduler
      @interviewscheduler = Interviewscheduler.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interviewscheduler_params
      params.require(:interviewscheduler).permit(:name, :description, :start_time, :end_time)
    end
end
