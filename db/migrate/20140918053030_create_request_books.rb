class CreateRequestBooks < ActiveRecord::Migration
  def change
    create_table :request_books do |t|
      t.string :book_name
      t.string :author_name
      t.string :status

      t.timestamps
    end
  end
end
