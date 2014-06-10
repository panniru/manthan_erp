class AddFormNoToAdmissions < ActiveRecord::Migration
  def change
    add_column :admissions, :form_no, :string
  end
end
