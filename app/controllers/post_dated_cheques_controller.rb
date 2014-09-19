class PostDatedChequesController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  authorize_resource
  def index
    respond_to do |format|
      format.json do
        @post_dated_cheques = PostDatedCheque.paginate(:page => params[:page].present? ? params[:page] : 1)
        render :json => @post_dated_cheques
      end
      format.html do
        render "index"
      end
    end
  end
  
  def create
    respond_to do |format|
      @post_dated_cheque = PostDatedCheque.new(cheque_params)
      format.json do
        render :json => @post_dated_cheque.save
      end
      format.html do
        if @post_dated_cheque.save
          flash[:success] = I18n.t :success, :scope => [:post_dated_cheque, :create]
          redirect_to post_dated_cheques_path
        else
          render "index"
        end
      end
    end
  end
  
  def create_bulk
    respond_to do |format|
      @post_dated_cheque_bulk = build_post_dated_cheque_from_bulk
      format.json do
        status = []
        if !@post_dated_cheque_bulk.empty? and @post_dated_cheque_bulk.map(&:valid?).all?
          status = @post_dated_cheque_bulk.map(&:save!)
        end
        render :json => status
      end
      format.html do
        if !@post_dated_cheque_bulk.empty? and @post_dated_cheque_bulk.map(&:valid?).all?
          @post_dated_cheque_bulk.each(&:save!)
          flash[:success] = I18n.t :success, :scope => [:post_dated_cheque , :create_bulk]
          redirect_to post_dated_cheques_path
        else
          flash.now[:fail] = I18n.t :fail, :scope => [:post_dated_cheque, :create_bulk]
          render "new"
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        render :json => @post_dated_cheque.update(cheque_params)
      end
      format.html do
        if @post_dated_cheque.update(cheque_params)
          flash[:success] = I18n.t :success, :scope => [:post_dated_cheque, :update]
          redirect_to post_dated_cheques_path
        else
          flash.now[:fail] = I18n.t :fail, :scope => [:post_dated_cheque, :update]
          render "edit"
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        render :json => @post_dated_cheque.destroy
      end
      format.html do
        if @post_dated_cheque.destroy
          flash[:success] = I18n.t :success, :scope => [:post_dated_cheque, :destroy]
        else
          flash.now[:fail] = I18n.t :fail, :scope => [:post_dated_cheque, :destroy]
        end
        redirect_to post_dated_cheques_path
      end
    end
  end

  def new
     @post_dated_cheques = PostDatedCheque.new
  end
  
  private
  
  def cheque_params
    params.require(:post_dated_cheque).permit( :date, :amount_per )
  end

  def cheque_attributes(param)
    param.permit( :date, :amount_per )
  end

  def build_post_dated_cheque_from_bulk
    params.require(:bulk_post_dated_cheques).select{|post_dated_cheque| post_dated_cheque["date"].present? and post_dated_cheque["amount_per"].present?}.map do |post_dated_cheque|
      post_dated_cheque_obj = nil
      if post_dated_cheque[:id].present?
        post_dated_cheque_obj = PostDatedCheque.find(post_dated_cheque[:id])
        post_dated_cheque.each do |key, val|
          post_dated_cheque_obj.send(key+"=", val) if post_dated_cheque_obj.attributes.include?(key)
        end
      else
        post_dated_cheque_obj = PostDatedCheque.new(cheque_attributes(post_dated_cheque))
      end
      post_dated_cheque_obj.month = Date::MONTHNAMES[Date.parse(post_dated_cheque["date"]).month]
      post_dated_cheque_obj
    end
  end
end

