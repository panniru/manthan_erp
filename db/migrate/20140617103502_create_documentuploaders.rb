class CreateDocumentuploaders < ActiveRecord::Migration
  def change
    create_table :documentuploaders do |t|
      t.string :name
      t.string :educational_certificates
      t.string :previous_employment_proof
      t.string :salary_slips_for_previous_months

      t.timestamps
    end
  end
end
