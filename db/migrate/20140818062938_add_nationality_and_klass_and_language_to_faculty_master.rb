class AddNationalityAndKlassAndLanguageToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :nationality, :string
    add_column :faculty_masters, :klass, :string
    add_column :faculty_masters, :language, :string
  end
end
