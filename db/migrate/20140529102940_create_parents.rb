class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :father_name
      t.string :mother_name
      t.string :guardian_name
      t.string :father_occupation
      t.string :mother_occupation
      t.string :guardian_occupation
      t.string :father_phone
      t.string :mother_phone
      t.string :guardian_phone
      t.string :father_email
      t.string :mother_email
      t.string :guardian_email
      t.string :address

      t.timestamps
    end
  end
end
