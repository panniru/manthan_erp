class AddAssessmentIdForAssessmentListings < ActiveRecord::Migration
  def change
  	add_column :assessment_listings, :assessment_id, :integer

  	remove_column :assessment_listings, :assessment_type_id, :integer
  end
end
