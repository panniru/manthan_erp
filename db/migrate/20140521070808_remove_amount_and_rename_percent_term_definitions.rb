class RemoveAmountAndRenamePercentTermDefinitions < ActiveRecord::Migration
  def change
   definitions, :amount, :string
    remove_column :term_definitions, :percent, :string
    add_colu remove_column :term_mn :term_definitions, :amount_per, :float
  end
end
