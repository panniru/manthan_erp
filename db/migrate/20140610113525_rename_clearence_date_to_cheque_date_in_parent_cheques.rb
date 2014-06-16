class RenameClearenceDateToChequeDateInParentCheques < ActiveRecord::Migration
  def change
    rename_column :parent_cheques, :clearence_date, :cheque_date
  end
end
