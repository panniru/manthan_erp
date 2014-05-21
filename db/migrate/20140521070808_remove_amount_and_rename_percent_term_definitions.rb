class RemoveAmountAndRenamePercentTermDefinitions < ActiveRecord::Migration
  def change
    remove_column :term_definitions, :amount, :string
    remove_column :term_definitions, :percent, :string
    add_column :term_definitions, :amount_per, :float
  end
end
