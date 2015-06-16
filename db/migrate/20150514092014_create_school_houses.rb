class CreateSchoolHouses < ActiveRecord::Migration
  def change
    create_table :school_houses do |t|
      t.string :house_name

      t.timestamps
    end
  end
end
