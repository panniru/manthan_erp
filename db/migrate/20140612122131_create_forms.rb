class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :name
      t.string :dob
      t.string :gender
      t.string :email
      t.string :mobile_no
      t.string :address
      t.string :language
      t.string :experience
      t.string :klass
      t.string :subject
      t.string :education_qualification
      t.string :expected_salary
      t.string :nationality
      t.string :post

      t.timestamps
    end
  end
end
