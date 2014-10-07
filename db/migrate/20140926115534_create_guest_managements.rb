class CreateGuestManagements < ActiveRecord::Migration
  def change
    create_table :guest_managements do |t|
      t.string :guest_name
      t.string :guest_phone
      t.text :guest_address
      t.string :guest_email
      t.string :purpose
      t.string :follow_up
      t.date :follow_up_date
      t.string :came_to_meet

      t.timestamps
    end
  end
end
