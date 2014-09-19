class AddUserIdToRequestBooks < ActiveRecord::Migration
 def change
  	add_column :request_books, :user_id, :integer
  end
end
