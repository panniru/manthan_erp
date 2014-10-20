class AddFatherNationalityAndMotherNationalityToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :father_nationality, :string
    add_column :admissions, :mother_nationality, :string
  end
end
