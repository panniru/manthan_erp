module DesignationMastersHelper

  def accountant_role
    @accountant ||= Role.find_by_code("accountant")
  end

  def admin_role
    @admin ||= Role.find_by_code("admin")
  end
end
