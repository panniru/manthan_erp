class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :grade

      t.timestamps
    end
  end
end
