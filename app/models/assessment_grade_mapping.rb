class AssessmentGradeMapping < ActiveRecord::Base
  belongs_to :grade_master 
  belongs_to :assessment_type
  belongs_to :student_master
  belongs_to :grading_master
  belongs_to :assessment_listing
  belongs_to :assessment
  belongs_to :assessment_result
  belongs_to :assessment_grade_mapping
  
  # def union
  #   "#{assessment_type_id}"
  # end

  def self.test_method(listing)
    p "222222222222"
    p listing
    a = listing.split('-')[0].to_i
    b = listing.split('-')[1].to_i
    c = AssessmentListing.select(:grade_master_id).where(:grade_master_id  => a)
    d = AssessmentResult.where(:assessment_listing_id => listing).map do |x|
      {student_master_id: x.student_master_id,assessment_type_id: x.assessment_listing.assessment.assessment_grade_mapping.assessment_type_id,student_name: x.student_master.name, grade_master_id: x.assessment_listing.grade_master_id, assessment_name: x.assessment_listing.assessment.assessment_name, no_of_times: x.assessment_listing.assessment.assessment_grade_mapping.no_of_times, assessment_type: x.assessment_listing.assessment.assessment_grade_mapping.assessment_type.assessment_type,assessment_grade_mapping_id: x.assessment_listing.assessment.assessment_grade_mapping_id, marks_scored: "", grading_name: ""}
    end
    
  end





end
