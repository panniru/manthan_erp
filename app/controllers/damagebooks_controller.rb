class DamagebooksController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  
  def create
    @damagebook = Damagebook.new(damagebook_params)
    if @damagebook.save
      flash[:success] = I18n.t :success, :scope => [:damagebook, :create]
      redirect_to damagebooks_path
    else
      render "new"
    end
  end
 
  def show
  end
  
  def index
    @damagebooks= Damagebook.all
    # @damagebooks = Damagebook.search(params[:search])
  end
  
  def new
    @damagebook = Damagebook.new
  end
  def edit
    @damagebook = Damagebook.find(params[:id])
  end
  def update
    @damagebook = Damagebook.find(params[:id])
    if @damagebook.update(damagebook_params)
      flash[:success] = I18n.t :success, :scope => [:damagebook, :update]
      redirect_to damagebooks_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:damagebook, :update]
      render "edit"
    end
  end
  def destroy
    @damagebook = Damagebook.find(params[:id])    
    if @damagebook.destroy
      flash[:success] = I18n.t :success, :scope => [:damagebook, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:damagebook, :destroy]
    end
    redirect_to damagebooks_path
  end
  def get_book_service_view     
    damage = Book.all.map do |damage|
      { isbn: damage.isbn , name: damage.name,author: damage.author,id: damage.id}     
     
    end 
    render :json => damage
  end
     
  private

  def damagebook_params
    params.require(:damagebook).permit(:isbn, :damage_type,  :book_stage, :damage_description)
  end
end
