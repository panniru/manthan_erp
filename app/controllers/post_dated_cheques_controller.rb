class PostDatedChequesController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  def index
    @post_dated_cheques = PostDatedCheque.paginate(:page => params[:page].present? ? params[:page] : 1)
  end

  def edit
  
  end
  
  def create_bulk
    @post_dated_cheque_bulk = build_post_dated_cheque_from_bulk
    if !@post_dated_cheque_bulk.empty? and @post_dated_cheque_bulk.map(&:valid?).all?
      @post_dated_cheque_bulk.each(&:save!)
      flash[:success] = I18n.t :success, :scope => [:post_dated_cheque , :create_bulk]
      redirect_to post_dated_cheques_path
      
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:post_dated_cheque, :create_bulk]
      render "new"
    end
  end

  def edit
  end

  def update
    if @post_dated_cheque.update(date_params)
      flash[:success] = I18n.t :success, :scope => [:post_dated_cheque, :update]
      redirect_to post_dated_cheques_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:post_dated_cheque, :update]
      render "edit"
    end
  end

  def destroy
    if @post_dated_cheque.destroy
      flash[:success] = I18n.t :success, :scope => [:post_dated_cheque, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:post_dated_cheque, :destroy]
    end
    redirect_to post_dated_cheques_path
  end
 
  
  def new
    @post_dated_cheques = PostDatedCheque.new
  end

  def show
  end

  private 

  def date_params
    params.require(:post_dated_cheque).permit(:date, :amount_per)
  end

  def build_post_dated_cheque_from_bulk
    params.require(:bulk_post_dated_cheques).select{|post_dated_cheque| post_dated_cheque["date"].present? and  post_dated_cheque["amount_per"].present?}.map do |post_dated_cheque|
      pd = PostDatedCheque.new(post_dated_cheque)
      pd.month = Date::MONTHNAMES[Date.parse(post_dated_cheque["date"]).month]
     
    end
  end
end

