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

  def damagebooks    
    damagebooks = Book.where('isbn = '+"'#{params[:my_Isbn]}'")
    damagebooks = damagebooks.map do |block|
      {book_id: params[:book_Id], isbn:block.isbn, name: block.name, author: block.author,book_stage: params[:book_Stage],damage_type: params[:damage_Type],damage_description: params[:damage_Description] }
    end
    damagebooks.each do |t|
      @temp=Damagebook.new()
      @temp.book_id= t[:book_id]
      @temp.isbn=t[:isbn]     
      @temp.book_stage=t[:book_stage]
      @temp.damage_type=t[:damage_type]
      @temp.damage_description=t[:damage_description]
      @temp.save
    end
    render :json => damagebooks
  end

  def get_damage_books     
    damage_books = Damagebook.all.map do |damage|
      {id: damage.id, book_id: damage.book_id, name: damage.book.name, isbn: damage.book.isbn, author: damage.book.author, book_stage: damage.book_stage, damage_type: damage.damage_type, damage_description: damage.damage_description}
    end 
    render :json => damage_books
  end  
 
  private

  def damagebook_params
    params.require(:damagebook).permit(:isbn, :damage_type,  :book_stage, :damage_description)
  end
end
