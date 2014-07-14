class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :authentication_keys => [:user_id]

  belongs_to :role
  has_one :parent

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
    

end
