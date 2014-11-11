class AddParentMailIdToCommunicationMails < ActiveRecord::Migration
  def change
    add_column :communication_mails, :parent_mail_id, :integer
  end
end
