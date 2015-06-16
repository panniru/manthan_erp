class LeavePermissionsController < ApplicationController
  skip_before_filter :verify_authenticity_token


  def get_all_details
    respond_to do |format|
      format.json do
        a = LeavePermission.all.where("faculty_master_id IS NOT NULL").map do |map| 
          {id: map.id,faculty_master_id: map.faculty_master_id, from_date: map.from_date, to_date: map.to_date, type_of_leave: map.type_of_leave,  status: map.status, reason: map.reason, name: map.faculty_master.faculty_name }
        end
        render :json => a
      end
    end
  end


  def approval
    @leave_permissions = LeavePermission.all
  end

  def get_exact_type_of_leave
    get_c = LeavePermission.maximum(:max_casual_leave).to_f
    get_cc = LeavePermission.minimum(:max_casual_leave).to_f
    get_s = LeavePermission.maximum(:max_sick_leave).to_f
    get_ss = LeavePermission.minimum(:max_sick_leave).to_f
    a =  SetupMaster.maximum(:sick_leave).to_f 
    
    p "6555555555555555555555555"
    p a
    p get_s
    
    if params[:type_of_leave] == "Casual Leave"
      if LeavePermission.first == nil
        @get_count = SetupMaster.maximum(:casual_leave).to_f 
      elsif
        if LeavePermission.where(:type_of_leave => "Casual Leave")
          @get_count = LeavePermission.minimum(:casual_leave_count)
        else
          @get_count = LeavePermission.maximum(:max_casual_leave)
        end
      else
        @get_count = LeavePermission.maximum(:max_casual_leave)
      end
    elsif params[:type_of_leave] == "Sick Leave"
      if LeavePermission.first == nil
        @get_count = SetupMaster.maximum(:sick_leave).to_f 
      elsif
        if LeavePermission.where(:type_of_leave => "Sick Leave")
          @get_count = LeavePermission.minimum(:sick_leave_count)
        else
          @get_count = LeavePermission.maximum(:max_sick_leave)
        end
      else
        @get_count = LeavePermission.maximum(:max_sick_leave)
      end
    end
   
      respond_to do |format|
      format.html do
      end
      format.json do
        render :json => @get_count.to_f
      end
    end
  end



  def get_exact_json_count
    if LeavePermission.maximum(:max_casual_leave) > LeavePermission.minimum(:max_casual_leave)
      @get_count = LeavePermission.this_test(current_user.faculty_master)
    else
      @get_count = LeavePermission.initial_count(current_user.faculty_master)
    end
    
      respond_to do |format|
        format.html do
        end
        format.json do
          render :json => @get_count[0]
        end
      end
  end




  def get_type_of_leaves_count
    if LeavePermission.minimum(:casual_leave_count) == "0.0" && LeavePermission.minimum(:sick_leave_count) == "0.0"
      @get_count = ""
    else
      @get_count = "not"
    end
    respond_to do |format|
      format.html do
      end
      format.json do
          render :json => @get_count
      end
    end
  end
  def edit
    
  end

  def update_leave_permission_status
    respond_to do |format|
      format.json do
        status = params[:status]
        p "1111111111"
        p status
        p params[:status]
        status.each do |t|      
          @status = LeavePermission.find(t['id'])    
          @status.status = t['status']
          @status.save
        end
        render :json => true    
      end
    end
  end



  def count_no
    hash = LeavePermission.get_faculty_details(current_user.faculty_master, params[:type_of_leave])
    respond_to do |format|
      format.json do
        render :json => hash 
      end
    end
    # @get_count = LeavePermission.all.map do |x|
    #   {casual_leave: x.get_casual_of_leaves_count(current_user), sick_leave: x.get_sick_of_leaves_count(current_user), loss_of_pay: x.get_loss_of_leaves_count(current_user)}
    # end
    # respond_to do |format|
    #   format.html do
    #   end
    #   format.json do
    #     render :json => @get_count[0]
    #   end
    # end
  end


  def get_date
    
    @jsondata = LeavePermission.get_leaves(current_user, params[:dates])
    respond_to do |format|
      format.html do
        
      end
      format.json do
        render :json => @jsondata
      end
    end
  end
  
  
  def index
    @leave_permission = LeavePermission.new
  end
  
  def approval
  end

  def approval_status
    @leave_permissions = LeavePermission.get_details(current_user)
    respond_to do |format|
      format.json do
        render :json => @leave_permissions
      end
      format.html do
        render "approval_status"
      end
    end
    p @leave_permissions
  end
  
  
  def create
    @leave_permission = LeavePermission.new(permission_params)
    @leave_permission.max_casual_leave = LeavePermission.get_casual_leave(current_user)
    @leave_permission.max_sick_leave = LeavePermission.get_sick_leave(current_user)
    @leave_permission.faculty_master_id = LeavePermission.get_faculty_attendance_id(current_user)
    @casual_leave_count = LeavePermission.get_casual_leave(current_user) - LeavePermission.get_leaves(current_user, @leave_permission.from_date, @leave_permission.to_date, @leave_permission.from_day, @leave_permission.to_day)
    @sick_leave_count = LeavePermission.get_sick_leave(current_user) - LeavePermission.get_leaves(current_user, @leave_permission.from_date, @leave_permission.to_date, @leave_permission.from_day, @leave_permission.to_day)
    @loss_of_pay_count = LeavePermission.get_leaves(current_user, @leave_permission.from_date, @leave_permission.to_date, @leave_permission.from_day, @leave_permission.to_day)

    if (@leave_permission.type_of_leave == 'Casual Leave')
      if @leave_permission.max_casual_leave >= 0
        @leave_permission.casual_leave_count = @casual_leave_count
      else 
        @leave_permission.loss_of_pay_count = @loss_of_pay_count
      end

    elsif (@leave_permission.type_of_leave == 'Sick Leave')
      if @leave_permission.max_sick_leave >= 0
        @leave_permission.sick_leave_count = @sick_leave_count
      else 
        @leave_permission.loss_of_pay_count = @loss_of_pay_count
      end
    else
      if (@leave_permission.type_of_leave == 'Loss of Pay')
        @leave_permission.loss_of_pay_count = @loss_of_pay_count
      end
    end
    respond_to do |format|
      if @leave_permission.save 
        format.html { redirect_to approval_status_leave_permissions_path, notice: 'Leave Form was successfully created.' }
      else
        format.html { render action: 'index' }
      end
    end
  end
  

  def get_holidays
    values = LeavePermission.get_leaves(current_user, params[:dates])
    respond_to do |format|
      format.json do
        render :json => values
        end
    end
  end

  # def update
  #   @leave_permission = LeavePermission.find(params[:id])
  #   respond_to do |format|
  #     format.json do 
  #       render :json => @leave_permission.update(permission_params)
  #     end
  #     format.html do
  #       render "index"
  #     end
  #   end
  # end
  

  def approval_item
    @leave_permission = LeavePermission.find(params[:id])
    respond_to do |format|
      format.json do 
        render :json => @leave_permission.update(permission_params)
      end
      format.html do
        render "index"
      end
    end
      
  end



  
  def permission_params
    params.require(:leave_permission).permit(:from_day, :to_day, :from_date, :to_date, :reason, :type_of_leave, :status, :bal_leave, :casual_leave_count, :sick_leave_count, :faculty_attendance_id, :dates, :max_casual_leave, :max_sick_leave, :loss_of_pay_count)
    
  end

  
end
