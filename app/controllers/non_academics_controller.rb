class NonAcademicsController < ApplicationController
  def get_non_academics_subjects
    respond_to do |format|
      format.json do         
        @activity_masters = SubjectMaster.where(subject_type: "non_academics").map do |nas|
          {id: nas.id, activity_name: nas.subject_name}
        end
        render :json => @activity_masters
      end
    end
  end
end
