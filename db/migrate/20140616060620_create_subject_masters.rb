class CreateSubjectMasters < ActiveRecord::Migration
  def change
    create_table :subject_masters do |t|
      t.string :subject

      t.timestamps
    end
  end
end
