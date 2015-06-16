class CreateGradingDefaults < ActiveRecord::Migration
  def change
    create_table :grading_defaults do |t|
      t.string :pass_text_1
      t.string :pass_text_2
      t.string :pass_text_3
      t.string :pass_text_4
      t.string :pass_text_5
      t.string :pass_text_6
      t.string :pass_criteria_1
      t.string :pass_criteria_2
      t.string :pass_criteria_3
      t.string :pass_criteria_4
      t.string :pass_criteria_5
      t.string :pass_criteria_6

      t.timestamps
    end
  end
end
