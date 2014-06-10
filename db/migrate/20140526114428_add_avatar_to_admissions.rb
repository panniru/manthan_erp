class AddAvatarToAdmissions < ActiveRecord::Migration
  def change
    add_column :admissions, :avatar, :string
  end
end
