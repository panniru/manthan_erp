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
  
  def save_academic_terms
    respond_to do |format|
      format.json do        
        academic_terms = params[:academic_terms]
        academic_terms.each do |t|         
          if t["id"].present?           
            @academic_term = AcademicTerm.find(t["id"]) 
            @academic_term.term_name = t['term_name'] 
            @academic_term.from_date = t['from_date'] 
            @academic_term.to_date = t['to_date']             
            @academic_term.save
          else
            @academic_term = AcademicTerm.new(add_academic_term_params(t))
            @academic_term.save
          end
        end         
        render :json => true
      end
    end
  end

  
  def add_academic_term_params(params)   
    params.permit(:term_name, :from_date, :to_date)
  end

  def delete_academic_terms
    respond_to do |format|
      format.json do       
        if params[:academic_term_id].present?
          AcademicTerm.find(params[:academic_term_id]).destroy   
        end
        render :json => true
      end
    end
  end
  
end
