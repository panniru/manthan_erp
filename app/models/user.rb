class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :authentication_keys => [:user_id]

  belongs_to :role
  has_one :parent, :class_name => "ParentMaster" 
  has_one :faculty_master

  scope :belongs_to_role , lambda{|role| where("role_id = ?", role)}

  def name
    case
    when parent?
      "#{parent.mother_name} - #{parent.father_name}"
    when teacher?
      faculty_master.faculty_name
    else
      role_code.titleize
    end
  end

  def can_mail_to
    case 
    when parent?
      Role.where(:code => ["admin", "principal", "teacher", "transport_head", "librarian"])
    when (admin? or principal? or bod?)
      Role.where("code != ?", role_code)
    when (accountant? or  canteenmanager? )
      Role.where(:code => ["admin", "principal"])
    when (transport_head? or librarian?)
      Role.where(:code => ["admin", "principal", "parent", "teacher"])
    end
  end


  def admin?
    role_code == "admin"
  end

  def parent?
    role_code == "parent"
  end

  def accountant?
     role_code == "accountant"
  end

  def role_code
    self.role.code
  end

  def teacher?
    self.role.code == "teacher"
  end

  def librarian?
    self.role.code == "librarian"
  end
  
  def principal?
    self.role.code == "principal"
  end
    
  def transport_head?
    self.role.code == "transport_head"
  end

  def canteenmanager?
    self.role.code == "canteenmanager"
  end

  def auto_complete_user_mail_display
    "#{user_id}   #{email}"
  end

end
