class CreateDonateBooks < ActiveRecord::Migration
  def change
    create_table :donate_books do |t|
      t.integer :book_id
      t.string :student_name
      t.string :grade_name
      t.string :section_name
      t.date :date_of_donation

      t.timestamps
    end
  end
end
