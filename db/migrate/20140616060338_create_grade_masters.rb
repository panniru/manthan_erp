class CreateGradeMasters < ActiveRecord::Migration
  def change
    create_table :grade_masters do |t|
      t.string :grade

      t.timestamps
    end
  end
end
