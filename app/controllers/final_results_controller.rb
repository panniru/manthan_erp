class FinalResultsController < ApplicationController

  def get_assessment_grade_mappings_service
    respond_to do |format|
      format.json do        
        assessment_mappings = AssessmentListing.all
        assessment_mappings = assessment_mappings.each.map do |mapping|
          
          {id: mapping.id, grade_master_id: mapping.grade_master_id, grade_name: mapping.grade_master.grade_name, assessment_type_id: mapping.assessment.assessment_grade_mapping.assessment_type_id, assessment_type: mapping.assessment.assessment_grade_mapping.assessment_type.assessment_type, no_of_times: mapping.assessment.assessment_grade_mapping.no_of_times, union: mapping.id} 
        end
        render :json => assessment_mappings 
      end
    end
  end

  def grading_defaults
    p "2222222222222222"
    a = params[:f].to_i
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
    # if a.between?(gh,hi) 
    #   assessment_mappings = GradingMaster.where(:grading_name => fgg).map do |x|
    #     {grading_name: x.grading_name}
    #   end
    # end
     
    
    respond_to do |format|
      format.json do        
        render :json => assessment_mappings 
      end
      format.html do
      end
    end
  end


  def get_values
    
    respond_to do |format|
      format.json  do
        listing = (params[:selected_user])
        f = params[:f].to_i
        a = params[:selected_user].split('-')[0].to_i
        b = params[:selected_user].split('-')[1].to_i
        p "11111111111111"
        p a 
        p b
        @list = AssessmentGradeMapping.test_method(listing)
        p @list
     
        render :json => @list
      end
    end
  end

  # def create
  #   @final_result = FinalResult.new(final_result_params)
  #   if @final_result.save
  #     redirect_to final_results_path
  #   else
  #     render "new"
  #   end
  # end 
  
  # def show
  #   @final_result = FinalResult.find(params[:id])    
  # end

  # def index
  #   @final_results= FinalResult.all
  # end
  
  # def new
  #   @final_result = FinalResult.new
  # end
  
  # def edit
  #   @final_result = FinalResult.find(params[:id])
  # end

  # def update
  #   @final_result = FinalResult.find(params[:id])
  #   if @final_result.update(final_result_params)
  #     redirect_to final_results_path
  #   else
  #     render "edit"
  #   end
  # end

  # def destroy
  #   @final_result = FinalResult.find(params[:id])    
  #   @final_result.destroy
  #   redirect_to final_results_path
  # end

  # private
  # def final_result_params
  #   params.require(:final_result).permit(:grade_master_id, :student_master_id, :assessment_type_id, :no_of_times, :grading_master_id, :scored_marks, :assessment_grade_mapping_id)
  # end



end
