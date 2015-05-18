class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @messages = Message.new
  end

  def show
    @messages = Message.find(params[:id])
  end
  
  def create
    @messages = Message.new(message_params)
    if @messages.save
      redirect_to  messages_path
    else
      render "new"
    end
  end

  def message_params
    params.require(:message).permit(:message_type,:content,:subject)
  end
  

end
