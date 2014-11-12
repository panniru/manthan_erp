module MessageDetail

  class MessageActor
    include Virtus.model
    attribute :user_id
    attribute :user_name
    attribute :role_id
    attribute :role_code
    attribute :name
  end

  class ReplyMessage
    include Virtus.model
    attribute :to_user_id
    attribute :user_name
    attribute :content
    attribute :parent_mail_id
  end

  class Message
    include Virtus.model
    attribute :from, MessageDetail::MessageActor
    attribute :subject, String
    attribute :content, String
    attribute :id, Integer
    attribute :red, Boolean
    attribute :msg_count_in_conversation, Integer
    attribute :latest_mail_date
    
    def from= user
      @from = generate_actor(user)
    end
    
    private
    
    def generate_actor(user)
      MessageActor.new({:user_id => user.id, :user_name => user.user_id, :role_id => user.role_id, :role_code => user.role_code, :name => user.name})
    end
  end
end
