class AddTermDefinitionIdToParentCheques < ActiveRecord::Migration
  def change
    add_column :parent_cheques, :term_definition_id, :integer
  end
end
