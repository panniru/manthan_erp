class CommunicationMailFormObject
  include Virtus.model
  attribute :to, String
  attribute :roles, Array[Role]
  attribute :grade_master_id, String
  attribute :section_master_id, String
  attribute :student_masters
  attribute :subject, String
  attribute :content, String

  def initialize(user)
    @roles = user.can_mail_to.map{|role| {id: role.id, code: role.code.titleize, selected: false}}
  end
end
