class CreateRequestNewBooks < ActiveRecord::Migration
  def change
    create_table :request_new_books do |t|
      t.string :book_name
      t.string :author_name

      t.timestamps
    end
  end
end
