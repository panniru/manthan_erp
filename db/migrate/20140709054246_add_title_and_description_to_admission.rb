class AddTitleAndDescriptionToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :title, :string
    add_column :admissions, :description, :string
  end
end
