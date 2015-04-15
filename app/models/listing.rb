class Listing < ActiveRecord::Base
  
  belongs_to :subject_master
  belongs_to :grade_master

  def union
    "#{grade_master_id} - #{subject_master_id}"
  end

  # def self.this_grade(selected_user)
  #   a = Listing.find_by_sql("select grade_master_id::integer || '-' || subject_master_id::integer AS union,grade_master_id, subject_master_id, assessment_name, assessment_description, assessment_date from listings group by grade_master_id, subject_master_id, assessment_name, assessment_description, assessment_date;")
  #   p "785"
  #   p a
  # end


  def self.get_value(selected_user)
    
    grade = Listing.all
    data = []
    data = grade.map do |x|
      {grade_master_id: x.grade_master_id, subject_master_id: x.subject_master_id, assessment_date: x.assessment_date, assessment_description: x.assessment_description, assessment_name: x.assessment_name, union: x.union}
    end
    return data
  end
end
