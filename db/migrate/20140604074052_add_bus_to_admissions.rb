class AddBusToAdmissions < ActiveRecord::Migration
  def change
    add_column :admissions, :bus, :string
  end
end
