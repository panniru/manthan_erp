class RemoveKlassFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :klass, :string
  end
end
