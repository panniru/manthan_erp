class SchedulesController < ApplicationController
 def create
    @calendar = Calendar.new(calendar_params)
    if @calendar.save
      flash[:success] = I18n.t :success, :scope => [:calendar, :create]
      redirect_to schedules_index_path
    else
      render "new"
    end
  end

  def index
    @calendar = Calendar.all
  end

  def new
    @calendar = Calendar.new
 end
  
 

  def show
    
  end
  
  
  private

  def calendar_params
    params.require(:calendar).permit(:event, :teacher, :date, :from, :to)
  end
end

