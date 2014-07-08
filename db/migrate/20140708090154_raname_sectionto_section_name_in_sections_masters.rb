class RanameSectiontoSectionNameInSectionsMasters < ActiveRecord::Migration
  def change
    change_table :section_masters do |t|
      t.rename :section, :section_name
  	end
  end
end
