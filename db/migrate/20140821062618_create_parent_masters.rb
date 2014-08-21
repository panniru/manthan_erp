class CreateParentMasters < ActiveRecord::Migration
  def change
    create_table :parent_masters do |t|
      t.string :father_name
      t.string :mother_name
      t.string :father_mobile
      t.string :mother_mobile
      t.string :father_email
      t.string :mother_email
      t.string :father_office_address
      t.string :mother_office_address
      t.string :father_office_telephone
      t.string :mother_office_telephone
      t.string :father_religion
      t.string :mother_religion
      t.string :father_employer
      t.string :mother_employer
      t.string :father_occupation
      t.string :mother_occupation
      t.string :father_company
      t.string :mother_company
      t.integer :student_master_id

      t.timestamps
    end
  end
end
