class AddResultTypeToLabResults < ActiveRecord::Migration
  def change
    add_column :lab_results, :result_type, :string
  end
end
