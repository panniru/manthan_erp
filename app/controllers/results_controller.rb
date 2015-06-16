class ResultsController < ApplicationController


  def index
    p "111111111111111111"
    p params[:id]
    @results = LabResult.all.where(:student_master_id => params[:id])
    @lab_results = LabResult.all.where(:student_master_id => params[:id]).where(:result_type => 'labs')
    @aca_results = LabResult.all.where(:student_master_id => params[:id]).where(:result_type => 'academics')
  end



  def get_student_forms
    final = []
    results = []
    academics = []
    aca_results = []
    non_academics = []
    non_results = []
    big_json = []
    @results = LabResult.all.where(:student_master_id => params[:id]).each do |x|
      results << {assessment_type: x.listing.lab_assessment.assessment_type, subject: x.listing.subject_master.subject_name,grading: x.grading_master.grading_name}
    final << {labs: results}
    end
    @aca_results = AssessmentResult.all.where(:student_master_id => params[:id]).where(:result_type => 'academics').each do |x|
        academics << {assessment_type: x.assessment_listing.assessment.assessment_grade_mapping.assessment_type.assessment_type, subject: x.assessment_listing.subject_master.subject_name,grading: x.grading_master.grading_name}
        aca_results << {academics: academics}
    end
    @non_results = AssessmentResult.all.where(:student_master_id => params[:id]).where(:result_type => 'non_academics').each do |x|
      
      non_academics << {assessment_type: x.assessment_listing.assessment.assessment_grade_mapping.assessment_type.assessment_type, subject: x.assessment_listing.subject_master.subject_name,grading: x.grading_master.grading_name}

      
      non_results << {non_academics: non_academics}

      p "@@@@@@@@@@@@@@"
      p final
    end
    final_results = StudentMaster.all.where(:id => params[:id]).each do |x|
      big_json << {labs: results, academics: academics, non_academics: non_academics}
    end
    render :json => big_json.first
  end


  def get_all_results
    params[:klass]
    grade = params[:klass].split('-')[0].to_i
    section = params[:klass].split('-')[1].to_i
    lab_result = StudentMaster.all.where(:grade_master_id => grade, :section_master_id => section).map do |x|
      {id: x.id, student_name: x.name, grade: x.grade_master.grade_name,section: x.section_master.section_name}
    end    
    respond_to do |format|
      format.json do
        render :json => lab_result
      end
      format.html do
      end
    end
  end

  def get_klasses
    lab_result = LabResult.all.map do |x|
      {id: x.id, student_name: x.student_master.name, grade: x.student_master.grade_master.grade_name,grading: x.grading_master.grading_name , subject: x.listing.subject_master.subject_name, result_type: x.result_type}
    end
    respond_to do |format|
      format.json do
        render :json => lab_result
      end
      format.html do
      end
    end
  end

  def get_grades_and_sections
    get_grade = GradeSection.all.map do |x|
      {id: x.id, grade_master_id: x.grade_master_id, section_master_id: x.section_master_id, grade_name: x.grade_master.grade_name, section_name: x.section_master.section_name, union: x.union}
    end
    respond_to do |format|
      format.json do
        render :json => get_grade
      end
      format.html do
      end
    end
  end


  







end
