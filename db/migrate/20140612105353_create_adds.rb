class CreateAdds < ActiveRecord::Migration
  def change
    create_table :adds do |t|
      t.string :title
      t.string :date
      t.string :description

      t.timestamps
    end
  end
end
