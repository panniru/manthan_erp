class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :authentication_keys => [:user_id]

  belongs_to :role
  has_one :parent

  def admin?
    self.role.code == "admin"
  end

  def parent?
    self.role.code == "parent"
  end

  def accountant?
    self.role.code == "accountant"
  end

  def teacher?
    self.role.code == "teacher"
  end


end
