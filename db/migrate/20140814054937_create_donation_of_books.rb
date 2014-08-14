class CreateDonationOfBooks < ActiveRecord::Migration
  def change
    create_table :donation_of_books do |t|
      t.string :book_name
      t.string :isbn
      t.string :year_of_publishing
      t.string :number_of_copies
      t.string :book_type
      t.string :student_name
      t.string :section
      t.string :grade

      t.timestamps
    end
  end
end
