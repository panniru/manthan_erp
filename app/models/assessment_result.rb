class AssessmentResult < ActiveRecord::Base
  belongs_to :student_master
  belongs_to :grading_master
  belongs_to :assessment_listing
  belongs_to :assessment
  belongs_to :assessment_grade_mapping


  def self.get_value(selected_user)
    
    grade = AssessmentResult.all
    data = []
    data = grade.map do |x|
      { student_master_id: x.student_master_id}
    end
    return data
  end

    def grading_defaults(f)
    p "2222222222222222"
    a = f.to_i
    p a
    array = GradingMaster.order('grading_score ASC').pluck(:grading_score).uniq
    array_ne= [0,100] + array.to_a
    array_new = array_ne.sort
    p array_new
    grading = GradingMaster.order('grading_score ASC').pluck(:grading_name).uniq
    grading_name = grading.to_a
    p grading_name
    ab = array_new[0]
    bc = array_new[1]
    cd = array_new[2]
    de = array_new[3]
    ef = array_new[4]
    fg = array_new[5]
    gh = array_new[6]
    # hi = array_new[7]
    abg = grading_name[0]
    bcg = grading_name[1]
    cdg = grading_name[2]
    deg = grading_name[3]
    efg = grading_name[4]
    fgg = grading_name[5]
  
    if a.between?(ab, bc) 
      assessment_mappings = GradingMaster.where(:grading_name => abg).map do |x|
        {grading_name: x.grading_name, grading_master_id: x.id}
      end
    end
   
     if a.between?(bc,cd) 
      assessment_mappings = GradingMaster.where(:grading_name => bcg).map do |x|
        {grading_name: x.grading_name, grading_master_id: x.id}
      end
    end
    if a.between?(cd,de) 
      assessment_mappings = GradingMaster.where(:grading_name => cdg).map do |x|
        {grading_name: x.grading_name, grading_master_id: x.id}
      end
    end
    if a.between?(de,ef) 
      assessment_mappings = GradingMaster.where(:grading_name => deg).map do |x|
        {grading_name: x.grading_name, grading_master_id: x.id}
      end
    end
    if a.between?(ef,fg) 
      assessment_mappings = GradingMaster.where(:grading_name => efg).map do |x|
        {grading_name: x.grading_name, grading_master_id: x.id}
      end
    end
    if a.between?(fg,gh) 
      assessment_mappings = GradingMaster.where(:grading_name => fgg).map do |x|
        {grading_name: x.grading_name, grading_master_id: x.id}
      end
    end
    if a > gh
      assessment_mappings = GradingMaster.where(:grading_name => fgg).map do |x|
        {grading_name: x.grading_name, grading_master_id: x.id}
      end
    end
    end
    
end
