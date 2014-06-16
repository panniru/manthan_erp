class CreateSectionMasters < ActiveRecord::Migration
  def change
    create_table :section_masters do |t|
      t.string :section

      t.timestamps
    end
  end
end
