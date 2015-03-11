class CreateDepartmentMasters < ActiveRecord::Migration
  def change
    create_table :department_masters do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
