class NonAcademicsController < ApplicationController
  def get_non_academics_subjects
    respond_to do |format|
      format.json do         
        @subject_masters = SubjectMaster.where(subject_type: "non_academics").map do |nas|
          {id: nas.id, activity_name: nas.subject_name}
        end
        render :json => @subject_masters
      end
    end
  end
end
