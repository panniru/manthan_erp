class AddTermdateToTermDefinitions < ActiveRecord::Migration
  def change
    add_column :term_definitions, :termdate, :string
  end
end
