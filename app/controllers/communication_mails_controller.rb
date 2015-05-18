class CommunicationMailsController < ApplicationController
  load_resource :only => [:mail_detail, :reply, :mark_as_read]
  authorize_resource
  

  def new
    respond_to do |format|
      format.html
      format.json do
        render :json => CommunicationMailFormObject.new(current_user)
      end
    end
  end

  def send_mail
    respond_to do |format|
      format.json do
        p "1111111111111111111111111111111111111111111111111111111111111111"
        p params[:communication_mail_form_object]
        mail_service = CommunicationMailService.new(current_user, params[:communication_mail_form_object])
        status = mail_service.send_mail
        render :json => {status: status}
      end
    end
  end

  def index
    respond_to do |format|
      format.json do
        page = params[:page].present? ? params[:page] : 1
        render :json => CommunicationMail.user_mails(current_user, params[:filter_by], page)
      end
      format.html
    end
  end

  def mail_detail
    respond_to do |format|
      format.json do
        render :json => {message_details: @communication_mail.children_details, mail_to_reply: @communication_mail.mail_to_reply(current_user)}
      end
    end
  end

  def reply
    respond_to do |format|
      format.json do
        render :json => {status: @communication_mail.reply(current_user, params[:reply_mail])}
      end
    end
  end

  def unread
    respond_to do |format|
      format.json do
        render :json => {unread_mail_count: CommunicationMail.recieved(current_user).unread.count}
      end
    end
  end

  def mark_as_read
    respond_to do |format|
      format.json do
        render :json => {status: @communication_mail.mark_as_read}
      end
    end
  end
  
end
