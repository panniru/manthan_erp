class AdmissionReportsController < ApplicationController
  def get_status_view
    #status_new = Admission.all.map do |status|
      status_new = Admission.select("status, count(*) as data").group("status")
    status_new.map{|ad| {:label => ad.status, :data => ad.data}}

    p "----------->"
    p status_new
    
    #  { label: status.status }
    #end
    render :json => status_new
  end
end
