class AddSchoolHouseToAdmissions < ActiveRecord::Migration
  def change
    add_column :admissions, :school_house, :string
  end
end
