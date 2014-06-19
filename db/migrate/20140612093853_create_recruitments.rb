class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.string :title
      t.string :education_details
      t.string :experience

      t.timestamps
    end
  end
end
