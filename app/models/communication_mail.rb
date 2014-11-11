#WillPaginate.per_page = 1
class CommunicationMail < ActiveRecord::Base
  validates :from, :presence => true, numericality: { only_integer: true }
  validates :to, :presence => true, numericality: { only_integer: true }
  validates :message_id, :presence => true
  
  belongs_to :message
  belongs_to :from_user, :class => User, :foreign_key => "from"
  belongs_to :to_user, :class => User, :foreign_key => "to"
  belongs_to :parent_mail, :class => CommunicationMail, :foreign_key => "parent_mail_id"

  scope :recieved, lambda{|user| where(:to => user)}
  scope :sent, lambda{|user| where(:from => user)}
  scope :unread, lambda{ where(:red => false)}
  # scope :red, lambda{|user| inbox(user).where(:red => true)}

  INBOX_QUERY = lambda{|user| "(WITH RECURSIVE children AS( SELECT id, parent_mail_id FROM communication_mails c where (c.to = #{user.id}) UNION SELECT p.id, p.parent_mail_id FROM communication_mails p, children ch where p.id = ch.parent_mail_id ) SELECT id FROM children where parent_mail_id is null ORDER BY created_at)"}

  SENT_MAIL_QUERY = lambda{|user| "(WITH RECURSIVE children AS( SELECT id, parent_mail_id FROM communication_mails c where (c.from = #{user.id}) UNION SELECT p.id, p.parent_mail_id FROM communication_mails p, children ch where p.id = ch.parent_mail_id ) SELECT id FROM children where parent_mail_id is null ORDER BY created_at)"}

  
  CHILDREN_MAIL_QUERY = lambda{|id| "WITH RECURSIVE children AS( SELECT * FROM communication_mails where id = #{id} UNION ALL SELECT p.* FROM communication_mails p, children ch where p.parent_mail_id = ch.id) SELECT * FROM children ORDER BY created_at;"}
  PARENT_MAIL_QUERY = lambda{|id| "WITH RECURSIVE children AS( SELECT * FROM communication_mails where id = #{id} UNION ALL SELECT p.* FROM communication_mails p, children ch where p.id = ch.parent_mail_id) SELECT * FROM children ORDER BY created_at;"}

  class << self
    def filtered_mails(current_user, filter, page)
      if respond_to? filter.to_sym 
        send(filter.to_sym, current_user, page)
      else
        all
      end
    end

    def inbox(user, page)
      self.where("id IN #{INBOX_QUERY.call(user)}").paginate(:page => page)
    end

    def sent(user, page)
      self.where("id IN #{SENT_MAIL_QUERY.call(user)}").paginate(:page => page)
    end
    
    def user_mails(current_user, filter, page)
      message_details = []
      mails = filtered_mails(current_user, filter, page)
      mails.each do |mail|
        msg_count_in_conversation = 0
        if mail.parent_mail_id.present?
          root_msg = mail.root_msg_in_conversation
          unless message_details.include? root_msg
            latest_mail_date = mail.created_at
            mail = root_msg
            mail.created_at = latest_mail_date
            message_details << mail
          end
        else
          message_details << mail
        end
      end
      message_details = message_details.map{|mail| 
        conversation_details = mail.conversation_details
        build_message_detail(mail, {child_msg_count_in_conversation: conversation_details[:msg_count_in_conversation], latest_mail_date: conversation_details[:latest_mail_date].try('strftime', '%d-%b-%y')})}
      JsonPagination.pagination_entries(mails).merge(mail_details: message_details)
    end
  
    def build_message_detail(mail, params)
      MessageDetail.new({:from => mail.from_user, :subject => mail.message.subject, :content => mail.message.content, :red => mail.red?, :id => mail.id, :msg_count_in_conversation => params[:child_msg_count_in_conversation], :latest_mail_date => params[:latest_mail_date]})
    end
    
  end
  
  def root_msg_in_conversation
    parent_mails.first
  end
  
  def conversation_details
    children = cheldren_mails
    {msg_count_in_conversation: children.count, latest_mail_date: children.last.created_at}
  end
  
  def cheldren_mails
    ActiveRecord::Base.connection.execute(CHILDREN_MAIL_QUERY.call(id)).map{|r| self.class.new(r)}
  end

  def parent_mails
    ActiveRecord::Base.connection.execute(PARENT_MAIL_QUERY.call(id)).map{|r| self.class.new(r)}
  end

  def children_details
    cheldren_mails.map do |mail|
      self.class.build_message_detail(mail, {latest_mail_date: mail.created_at.strftime("%d-%b-%y")})
    end
  end

  def reply(current_user, reply_params)
    content = reply_params[:content]
    to = reply_params[:to][:user_id]
    ActiveRecord::Base.transaction do
      begin
        message = Message.new({:content => content})
        if message.save!
          CommunicationMail.create({:from => current_user.id, :to => to, :red => false, :message_id => message.id, :parent_mail_id => self.id})
        end
      rescue Exception => e
        raise ActiveRecord::Rollback
        return false
      end
    end
    true
  end

  def mark_as_read
    self.update_attributes!({:red => true})
  end

end
