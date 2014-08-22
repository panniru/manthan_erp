class AcademicTermsController < ApplicationController
  
  def get_academic_terms_service
    respond_to do |format|
      format.json do       
        academic_terms = AcademicTerm.all
        academic_terms = academic_terms.each.map do |mapping|
          {id: mapping.id, term_name: mapping.term_name, from_date: mapping.from_date, to_date: mapping.to_date}
        end         
        render :json => academic_terms 
      end
    end
  end

end
