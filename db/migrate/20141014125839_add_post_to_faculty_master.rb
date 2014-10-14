class AddPostToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :post, :string
  end
end
