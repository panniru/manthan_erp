class AddFinalresultToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :finalresult, :string
  end
end
