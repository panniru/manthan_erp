class AdmissionReportsController < ApplicationController
  def get_status_view
    admissions  = Admission.select("status, count(*) as data").group("status")
    chart_color = ChartColor.new
    report_data = admissions.map{|ad| {:label => ad.status, :data => ad.data, :color => chart_color.next_color}}
    
    render :json => report_data
  end
  
  def get_admissions_on_status
    respond_to do |format|
      @admissions = Admission.where(:status => params[:status])
      format.json do
        report_data = @admissions.map do |field|
          { form_no: field.form_no, name: field.name, grade: field.grade, father_name: field.father_name, mobile: field.father_mobile, email: field.father_email}
        end
        render :json => report_data
      end
      format.pdf do
        render :pdf => "AdmissionStatus",
        :formats => [:pdf, :haml],
        :page_size  => 'A4',
        :margin => {:top => '8mm',
          :bottom => '8mm',
          :left => '10mm',
          :right => '10mm'}
      end
    end
  end

end
