class CommunicationMailService
  
  def initialize(current_user, params)
    @grade_master_id = params[:grade_master_id]
    @section_master_id = params[:section_master_id]
    @roles = params[:roles]
    @to = params[:to]
    @subject = params[:subject]
    @content = params[:content]
    @current_user = current_user
  end

  def send_mail
    to_users = []
    to_users << @to if @to.present?
    to_users.concat(role_based_to_users.map(&:id))
    if to_users.length > 0
      ActiveRecord::Base.transaction do
        begin
          message = Message.new({:subject => @subject, :content => @content})
          if message.save!
            to_users.each do |user_id|
              mail = CommunicationMail.create({:from => @current_user.id, :to => user_id, :red => false, :message_id => message.id})
            end
          end
        rescue Exception => e
          raise ActiveRecord::Rollback
          return false
        end
      end
    end
    true
  end

  private
  
  def role_based_to_users
    users = []
    @roles.each do |role|
      if role[:selected]
        role = Role.find(role[:id])
        if role.parent?
          users.concat(User.where(:id => apply_parent_filter))
        elsif role.teacher?
          users.concat(User.where(:id => apply_techer_filter))
        else
          users.concat(User.where(:role_id => role.id))
        end
      end
    end
    users
  end
  
  def apply_parent_filter
    student_master = StudentMaster.select(:parent_master_id)
    student_master = student_master.belongs_to_grade_master(@grade_master_id) if @grade_master_id.present?
    student_master = student_master.belongs_to_section_master(@section_master_id) if @section_master_id.present?
    parent = ParentMaster.select(:user_id).where(:id => student_master)
  end

  def apply_techer_filter
    faculty_master = FacultyMaster.select(:user_id)
    if @grade_master_id.present? and @section_master_id.present?
      teacher_grade_mapping = TeacherGradeMapping.select(:faculty_master_id)
      teacher_grade_mapping = teacher_grade_mapping.belongs_to_grade_master(@grade_master_id) if @grade_master_id.present?
      teacher_grade_mapping = teacher_grade_mapping.belongs_to_section_master(@section_master_id) if @section_master_id.present?
      faculty_master.where(:id => teacher_grade_mapping)
    end
    faculty_master
  end

  
end
