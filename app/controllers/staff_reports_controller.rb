class StaffReportsController < ApplicationController
  def get_status_view
    staffrecruits  = Staffrecruit.select("status, count(*) as data").group("status")
    chart_color = ChartColor.new
    report_data = staffrecruits.map{|ad| {:label => ad.status, :data => ad.data, :color => chart_color.next_color}}
    
    render :json => report_data
  end
  
  def get_staffrecruits_on_status
    respond_to do |format|
      @staffrecruits = Staffrecruit.where(:status => params[:status])
      format.json do
        report_data = @staffrecruits.map do |field|
          { form_no: field.form_no, name: field.faculty_name, post: field.post, mobile: field.mobile_no, email: field.email}
        end
        render :json => report_data
      end
      format.pdf do
        render :pdf => "Staff Admission",
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
