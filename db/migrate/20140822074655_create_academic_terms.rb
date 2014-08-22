class CreateAcademicTerms < ActiveRecord::Migration
  def change
    create_table :academic_terms do |t|
      t.string :term_name
      t.date :from_date
      t.date :to_date

      t.timestamps
    end
  end
end
