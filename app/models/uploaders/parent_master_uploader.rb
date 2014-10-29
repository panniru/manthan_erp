class ParentMasterUploader
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include Uploader
  
  def persisted?
    false
  end

  def initialize(params = {})
    super(params[:file])
  end

  def save
    super do |row|
      parent = ParentMaster.new
      parent.attributes = row.to_hash.slice("father_name", "mother_name", "guardian_name", "father_occupation", "mother_occupation", "guardian_occupation", "father_mobile", "mother_mobile", "guardian_mobile", "father_email", "mother_email", "guardian_email", "address_line1", "address_line2", "city", "state", "pin")
      user = User.new({:email => row["father_email"], :user_id => row["father_email"], :password => "welcome", :password_confirmation => "welcome", :role_id =>  parent_role.id})
      parent.user = user
      parent
    end
  end
  
  def parent_role
    @role ||= Role.find_by_code("parent")
  end
  
  def keys
    @keys ||= ParentMaster.new.attributes.keys
      #.map{|key| key.titleize}
  end

  def xls_template(options)
    CSV.generate(options) do |csv|
      csv << keys
    end
  end

end
