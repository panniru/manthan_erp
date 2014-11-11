class CreateCommunicationMails < ActiveRecord::Migration
  def change
    create_table :communication_mails do |t|
      t.integer :from
      t.integer :to
      t.integer :message_id
      t.boolean :red

      t.timestamps
    end
  end
end
