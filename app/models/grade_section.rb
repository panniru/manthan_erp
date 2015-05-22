class GradeSection < ActiveRecord::Base
  belongs_to :grade_master  
  belongs_to :section_master

  def union
    "#{grade_master_id} - #{section_master_id}"
  end

  # def self.get_value(selected_user)
    
  #   grade = .all
  #   data = []
  #   data = grade.map do |x|
  #     {id: x.id, student_name: x.student_master.name, grade: x.student_master.grade_master.grade_name,grading: x.grading_master.grading_name , subject: x.listing.subject_master.subject_name, result_type: x.result_type, union: x.union}
  #   end
  #   return data
  # end


end
